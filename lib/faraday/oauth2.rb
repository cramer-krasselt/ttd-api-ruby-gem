require 'faraday'
require 'base64'
require 'pry'

# @private
module FaradayMiddleware
  # @private
  class TTDApiOAuth2 < Faraday::Middleware
    def call(env)

      if env[:method] == :get or env[:method] == :delete
        if env[:url].query.nil?
          query = {}
        else
          query = Faraday::Utils.parse_query(env[:url].query)
        end

        if @token
          env[:request_headers] = env[:request_headers].merge('TTD-Auth' => "#{@token}")
        end
      else
        env[:body] ||= ""

        if @token
          env[:request_headers] = env[:request_headers]
            .merge('TTD-Auth' => "#{@token}")
        else
          env[:body] = {Login: @login, Password: @password}.to_json
        end
      end

      @app.call env
    end

    def initialize(app, login, password, token=nil)
      @app = app
      @login = login
      @password = password
      @token = token
    end
  end
end
