# auto_register: false
# frozen_string_literal: true

require "hanami/action"

module Gateway
  class Action < Hanami::Action

    include Errors

    before :validate_params
    before :validate_access_token

    private

    def validate_params(request, _response)
      halt 422, request.params.errors.to_json unless request.params.valid?
    end

    def validate_access_token(request, _response)
      given_token = request.env["HTTP_AUTHORIZATION"]&.sub(/\ABearer /, "")

      # fetch the refresh token from the db to check for existing session
      fetched_token = RedisClient.get(given_token)
      halt 401 if fetched_token.nil?

      # decode the refresh token first to validate its properties
      refresh_token = JSONWebToken.decode(fetched_token)
      remote_addr = request.env["REMOTE_ADDR"]
      user_agent = request.env["HTTP_USER_AGENT"]

      # halt if the refresh token is expired
      if refresh_token[:exp] <= Time.now.to_i
        halt 401
      end

      # halt if the recorded ip address and user agent do not match
      if refresh_token[:remote_addr] != remote_addr || refresh_token[:user_agent] != user_agent
        halt 401
      end

      # decode the access token now to check some properties
      access_token = JSONWebToken.decode(given_token)
      user_id = access_token[:id]
      halt 401 if user_id.blank?

      # next if the token is expired refresh it
      if access_token[:exp] <= Time.now.to_i
        access_token = JSONWebToken.encode({id: user_id})
        RedisClient.set(access_token, fetched_token)
      end

      # set the session and we're good to go
      Current.user_id = user_id
      Current.access_token = access_token
    end

    def set_auth_token(request, user)
      remote_addr = request.env["REMOTE_ADDR"]
      user_agent = request.env["HTTP_USER_AGENT"]

      access_token = JSONWebToken.encode({id: user.id})
      refresh_token = JSONWebToken.encode(
        {
          id: user.id,
          remote_addr: remote_addr,
          user_agent: user_agent
        },
        expires_in: Time.now + 3.days
      )

      RedisClient.set(access_token, refresh_token)

      Current.access_token = access_token
    end

  end
end
