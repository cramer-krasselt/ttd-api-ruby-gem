require 'faraday'
require 'base64'

# @private
module FaradayMiddleware
  # @private
  class CrimsonHexagonOAuth2 < Faraday::Middleware
    def call(env)

      # TODO: if @access_token expired, refresh

      if env[:method] == :get or env[:method] == :delete
        if env[:url].query.nil?
          query = {}
        else
          query = Faraday::Utils.parse_query(env[:url].query)
        end

        if @access_token and not query["password"]
          env[:url].query = Faraday::Utils.build_query(query.merge(:auth => @access_token))
          env[:request_headers] = env[:request_headers].merge('Authorization' => "Bearer #{@access_token}")
        elsif @username && @password and not query["password"]
          env[:url].query = Faraday::Utils.build_query(query.merge({
            username: @username,
            password: @password
          }))
        end
      else
        if @access_token and not env[:body] && env[:body][:password]
          env[:body] = {} if env[:body].nil?
          env[:body] = env[:body].merge(:auth => @access_token)
          env[:request_headers] = env[:request_headers].merge('Authorization' => "Bearer #{@access_token}")
        end
      end


      @app.call env
    end

    def initialize(app, username, password, access_token=nil)
      @app = app
      @username = username
      @password = password
      @access_token = access_token
    end
  end
end
