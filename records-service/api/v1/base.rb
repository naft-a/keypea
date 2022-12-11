# frozen_string_literal: true

require_relative "../authenticator"
require_relative "./endpoints/create_records"
require_relative "./endpoints/list_records"

module Api
  module V1
    class Base < Apia::API

      authenticator Authenticator

      scopes do
        add "records", "Allows keys management"
      end

      routes do
        schema

        group :keys do
          get "/records", endpoint: Endpoints::ListRecords
          post "/records", endpoint: Endpoints::CreateRecords
        end
      end

    end
  end
end
