require 'digest/sha1'
require 'uri'
require 'net/http'

OFFERS_ENDPOINT = 'http://api.sponsorpay.com/feed/v1/offers.json'
API_KEY = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'

DEFAULT_REQUEST_DATA = {
  format:       'json',
  appid:        157,
  locale:       'de',
  ip:           '109.235.143.113',
  offer_types:  112,
  device_id:    '2b6f0cc904d137be2e1730235f5664094b83'
}

require_relative './lib/fyber'

hashkey = Fyber::Hashkey.new(API_KEY)
offers_response = Fyber::OffersResponse.new(hashkey)
offers_request  = Fyber::OffersRequest.new(DEFAULT_REQUEST_DATA)

qs = offers_request.signed_querystring({
  timestamp: Time.now.to_i,
  uid: 'player1',
  pub0: 'campaign2',
  page: 1}, hashkey )

request = "#{OFFERS_ENDPOINT}?#{qs}"

uri = URI.parse(request)
response = Net::HTTP.get_response(uri)
signature = response['x-sponsorpay-response-signature']

json = offers_response.parse(response.body, signature)

puts json
