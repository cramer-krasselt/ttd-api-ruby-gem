module TTDApi
  class Client < API
    Dir[File.expand_path('../client/*.rb', __FILE__)].each { |f| require f }

    include TTDApi::Client::Advertiser
    include TTDApi::Client::AdGroup
    include TTDApi::Client::Campaign
    include TTDApi::Client::Creative
  end
end
