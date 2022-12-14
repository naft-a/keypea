# frozen_string_literal: true

module Api
  module V1
    module ArgumentSets
      class UserLookup < Apia::LookupArgumentSet

        name "User lookup"
        description "Provides for users to be looked up"

        argument :id, type: :string

        potential_error "UserNotFound" do
          code :user_not_found
          description "No user was found matching any of the criteria provided in the arguments"
          http_status 404
        end

        resolver do |set, _request|
          user = ::User.find(set[:id])
          raise_error "UserNotFound" if user.blank?

          user
        end

      end
    end
  end
end