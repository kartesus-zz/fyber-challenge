require 'digest/sha1'
require 'uri'
require 'net/http'

OFFERS_ENDPOINT = 'http://api.sponsorpay.com/feed/v1/offers.json'
API_KEY = 'b07a12df7d52e6c118e5d47d3f9e60135b109a1f'

REQUEST_APPID = 157
REQUEST_FORMAT = 'json'
REQUEST_DEVICEID = '2b6f0cc904d137be2e1730235f5664094b83'
REQUEST_LOCALE = 'de'
REQUEST_IP = '109.235.143.113'
REQUEST_OFFER_TYPES = 112

def request_data(uid, pub0, page)
  { format:       REQUEST_FORMAT,
    appid:        REQUEST_APPID,
    locale:       REQUEST_LOCALE,
    ip:           REQUEST_IP,
    offer_types:  REQUEST_OFFER_TYPES,
    device_id:    REQUEST_DEVICEID,
    timestamp:    Time.now.to_i,

    uid: uid,
    pub0: pub0,
    page: page }
end

def querystring(data)
  data.sort.reduce([]) {|qs, (k, v)| qs << "#{k}=#{v}" }.join('&')
end

def hashkey(querystring)
  Digest::SHA1.hexdigest("#{querystring}&#{API_KEY}")
end

qs = querystring request_data('player1', 'campaign2', 1)

request = "#{OFFERS_ENDPOINT}?#{qs}&hashkey=#{hashkey(qs)}"

uri = URI.parse(request)
response = Net::HTTP.get_response(uri)

puts "code: #{response.code}"
puts "signature: #{response['x-sponsorpay-response-signature']}"
puts response.body

puts (Digest::SHA1.hexdigest(response.body + API_KEY) == response['x-sponsorpay-response-signature'])
