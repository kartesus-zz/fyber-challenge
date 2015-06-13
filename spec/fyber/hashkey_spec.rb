require 'fyber/hashkey'

KEY = "e95a21621a1865bcbae3bee89c4d4f84"

REQUEST_PARAMS = "appid=157&device_id=2b6f0cc904d137be2e1730235f5664094b831186&ip=212.45.111.17&locale=de&page=2&ps_time=1312211903&pub0=campaign2&timestamp=1312553361&uid=player1"
REQUEST_HASH   = "7a2b1604c03d46eec1ecd4a686787b75dd693c4d"

RESPONSE_BODY = "{}"
RESPONSE_HASH = "85d5e1866c31434d8765b3bbe355454148004a0a"


RSpec.describe Fyber::Hashkey do
  # refer to http://developer.fyber.com/content/ios/offer-wall/offer-api/
  it "hashes request according to specs" do
    h = Fyber::Hashkey.new(KEY)
    expect(h.querystring(REQUEST_PARAMS)).to eq(REQUEST_HASH)
  end

  it "checks hash for response body" do
    h = Fyber::Hashkey.new(KEY)
    expect(h.valid_response?(RESPONSE_BODY, RESPONSE_HASH)).to be true
    expect(h.valid_response?(RESPONSE_BODY, 'wronghash')).to be false
  end
end
