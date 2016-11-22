require File.expand_path('../crimsonhexagon/error', __FILE__)
require File.expand_path('../crimsonhexagon/configuration', __FILE__)
require File.expand_path('../crimsonhexagon/api', __FILE__)
require File.expand_path('../crimsonhexagon/client', __FILE__)
require File.expand_path('../crimsonhexagon/monitor', __FILE__)
require File.expand_path('../crimsonhexagon/monitor/facebook', __FILE__)
require File.expand_path('../crimsonhexagon/monitor/instagram', __FILE__)
require File.expand_path('../crimsonhexagon/monitor/twitter', __FILE__)
require File.expand_path('../crimsonhexagon/response', __FILE__)

module CrimsonHexagon
  extend Configuration

  # Alias for CrimsonHexagon::Client.new
  #
  # @return [CrimsonHexagon::Client]
  def self.client(options={})
    CrimsonHexagon::Client.new(options)
  end

  # Delegate to CrimsonHexagon::Client
  def self.method_missing(method, *args, &block)
    return super unless client.respond_to?(method)
    client.send(method, *args, &block)
  end

  # Delegate to CrimsonHexagon::Client
  def self.respond_to?(method, include_all=false)
    return client.respond_to?(method, include_all) || super
  end
end
