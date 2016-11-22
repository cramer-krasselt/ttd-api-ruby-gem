module CrimsonHexagon
  # Defines HTTP request methods
  module OAuth
    # Return URL for OAuth authorization
    def authorize_url(options={})
      params = authorization_params.merge(options)
      connection.build_url("authenticate", params).to_s
    end

    # Return an access token from authorization
    def get_auth(options={})
      options["noExpiration"] ||= true
      params = auth_params.merge(options)
      get("authenticate", params, signature=false, raw=false, unformatted=true, no_response_wrapper=true)
    end

    private

    def authorization_params
      {
        :username => username
      }
    end

    def auth_params
      {
        :username => username,
        :password => password
      }
    end
  end
end
