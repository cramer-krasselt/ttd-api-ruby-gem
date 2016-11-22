module CrimsonHexagon
  # Wrapper for the CrimsonHexagon REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in http://instagram.com/developer/
  # @see http://instagram.com/developer/
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each{|f| require f}

    include CrimsonHexagon::Client::Utils

    include CrimsonHexagon::Client::Users
    include CrimsonHexagon::Client::Media
    include CrimsonHexagon::Client::Locations
    include CrimsonHexagon::Client::Geographies
    include CrimsonHexagon::Client::Tags
    include CrimsonHexagon::Client::Likes
    include CrimsonHexagon::Client::Subscriptions
    include CrimsonHexagon::Client::Embedding
  end
end
