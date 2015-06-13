require 'uri'
require 'net/http'

require_relative './fyber'

include Fyber

class OffersService
  def initialize
    @endpoint = 'http://api.sponsorpay.com/feed/v1/offers.json'
    @api_key  = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'

    @params = { format:       'json',
                appid:        157,
                locale:       'de',
                ip:           '109.235.143.113',
                offer_types:  112,
                device_id:    '2b6f0cc904d137be2e1730235f5664094b83' }

    @hashkey  = Hashkey.new(@api_key)
    @response = OffersResponse.new(@hashkey)
    @request  = OffersRequest.new(@params)
  end

  def fetch(params)
    querystring  = @request.signed_querystring(params, @hashkey)
    uri = URI.parse("#{@endpoint}?#{querystring}")
    response = Net::HTTP.get_response(uri)
    signature = response['x-sponsorpay-response-signature']
    @response.parse(response.body, signature)
  end
end
