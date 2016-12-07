require File.expand_path('../ttd_api/error', __FILE__)
require File.expand_path('../ttd_api/configuration', __FILE__)
require File.expand_path('../ttd_api/api', __FILE__)
require File.expand_path('../ttd_api/client', __FILE__)
require File.expand_path('../ttd_api/response', __FILE__)

module TTDApi
  extend Configuration

  def self.client(options={})
    TTDApi::Client.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  def self.respond_to?(method, include_all=false)
    return client.respond_to?(method, include_all) || super
  end
end
