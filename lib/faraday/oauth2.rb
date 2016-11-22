require 'faraday'
require 'base64'

# @private
module FaradayMiddleware
  # @private
  class CrimsonHexagonOAuth2 < Faraday::Middleware
    def call(env)

      if env[:method] == :get or env[:method] == :delete
        if env[:url].query.nil?
          query = {}
        else
          query = Faraday::Utils.parse_query(env[:url].query)
        end

        if @auth and not query["password"]
          env[:url].query = Faraday::Utils.build_query(query.merge(:auth => @auth))
          env[:request_headers] = env[:request_headers].merge('Authorization' => "Bearer #{@auth}")
        elsif @username && @password and not query["password"]
          env[:url].query = Faraday::Utils.build_query(query.merge({
            username: @username,
            password: @password
          }))
        end
      else
        if @auth and not env[:body] && env[:body][:password]
          env[:body] = {} if env[:body].nil?
          env[:body] = env[:body].merge(:auth => @auth)
          env[:request_headers] = env[:request_headers]
            .merge('Authorization' => "Bearer #{@auth}")
        end
      end

      @app.call env
    end

    def initialize(app, username, password, auth=nil)
      @app = app
      @username = username
      @password = password
      @auth = auth
    end
  end
end
