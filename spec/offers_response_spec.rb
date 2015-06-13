require 'offers_response'
require 'digest/sha1'

RSpec.describe Fyber::OffersResponse do
  it "raises error if response signature doesn't match" do
    response = Fyber::OffersResponse.new('apikey')
    expect {
      response.parse("{}", 'wrongkey')
    }.to raise_error
  end

  it "returns a json representation of the body" do
    body = %|{"foo": "bar"}|
    signature = Digest::SHA1.hexdigest(body + 'apikey')
    response = Fyber::OffersResponse.new('apikey')
    json = response.parse(body, signature)
    expect(json['foo']).to eq("bar")
  end
end
