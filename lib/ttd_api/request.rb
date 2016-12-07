require 'openssl'
require 'base64'
require 'pry'

module TTDApi
  # Defines HTTP request methods
  module Request
    # Perform an HTTP GET request
    def get(path, options={}, signature=false, raw=false, unformatted=true, no_response_wrapper=no_response_wrapper(), signed=sign_requests)
      request(:get, path, options, signature, raw, unformatted, no_response_wrapper, signed)
    end

    # Perform an HTTP POST request
    def post(path, options={}, signature=false, raw=false, unformatted=true, no_response_wrapper=no_response_wrapper(), signed=sign_requests)
      request(:post, path, options, signature, raw, unformatted, no_response_wrapper, signed)
    end

    # Perform an HTTP PUT request
    def put(path, options={},  signature=false, raw=false, unformatted=true, no_response_wrapper=no_response_wrapper(), signed=sign_requests)
      request(:put, path, options, signature, raw, unformatted, no_response_wrapper, signed)
    end

    # Perform an HTTP DELETE request
    def delete(path, options={}, signature=false, raw=false, unformatted=true, no_response_wrapper=no_response_wrapper(), signed=sign_requests)
      request(:delete, path, options, signature, raw, unformatted, no_response_wrapper, signed)
    end

    private

    # Perform an HTTP request
    def request(method, path, options, signature=false, raw=false, unformatted=true, no_response_wrapper=false, signed=sign_requests)
      response = connection(raw).send(method) do |request|
        path = formatted_path(path) unless unformatted

        request.headers['Content-Type'] = 'application/json'

        case method
        when :get, :delete
          request.url(URI.encode(path), options)
        when :post, :put
          request.path = URI.encode(path)
          request.body = options.to_json unless options.empty?
        end
      end
      return response if raw
      return response.body if no_response_wrapper
      return Response.create(response.body)
    end

    def formatted_path(path)
      [path, format].compact.join('.')
    end
  end
end
