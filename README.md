# TTD Unofficial gem
Quick hack on the Instagram Gem, adapted for the TTD Api.

Not endpoint-complete by a far cry, not even tested at all.

This works for my purposes currently, but is obviously a use-at-own-risk piece of software.

## Usage

```ruby
require 'ttd_api'

TTDApi.configure do |config|
    # Required
    config.login	= ENV['TTD_LOGIN']
    config.password	= ENV['TTD_PASSWORD']
    # Optional
    config.partner_id	= ENV['TTD_PARTNER_ID']
end

auth_result = TTDApi.get_token
#<Hashie::Mash ... >

client = TTDApi::Client.new(token: auth_result.Token)
#<TTDApi::Client ... >

client.advertisers_by_partner(TTDApi.partner_id)
#<Hashie::Mash ... >
```
