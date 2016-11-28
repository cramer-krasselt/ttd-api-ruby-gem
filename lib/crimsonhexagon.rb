require File.expand_path('../crimsonhexagon/error', __FILE__)
require File.expand_path('../crimsonhexagon/configuration', __FILE__)
require File.expand_path('../crimsonhexagon/api', __FILE__)
require File.expand_path('../crimsonhexagon/monitor', __FILE__)
require File.expand_path('../crimsonhexagon/monitor/facebook', __FILE__)
require File.expand_path('../crimsonhexagon/monitor/instagram', __FILE__)
require File.expand_path('../crimsonhexagon/monitor/twitter', __FILE__)
require File.expand_path('../crimsonhexagon/response', __FILE__)
require File.expand_path('../crimsonhexagon/base', __FILE__)

module CrimsonHexagon
  extend Configuration

  def self.base(options={})
    CrimsonHexagon::Base.new(options)
  end

  def self.method_missing(method, *args, &block)
    return super unless base.respond_to?(method)
    base.send(method, *args, &block)
  end

  def self.respond_to?(method, include_all=false)
    return base.respond_to?(method, include_all) || super
  end
end
