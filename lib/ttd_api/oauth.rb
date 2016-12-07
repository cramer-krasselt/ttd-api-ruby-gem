module TTDApi
  # Defines HTTP request methods
  module OAuth
    # Return URL for OAuth authorization
    def authorize_url(options={})
      connection.build_url("authentication").to_s
    end

    # Return an access token from authorization
    def get_token(options={})
      params = auth_params.merge(options)
      post("authentication", params, signature=false, raw=false, unformatted=true, no_response_wrapper=true)
    end

    private

    def authorization_params
      {
        :Login => login
      }
    end

    def auth_params
      {
        :Login => login,
        :Password => password
      }
    end
  end
end
