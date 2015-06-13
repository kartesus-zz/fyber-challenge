require 'offers_response'

RSpec.describe Fyber::OffersResponse do
  it "raises error if response signature doesn't match" do
    hashkey = double()
    allow(hashkey).to receive(:valid_response?) { false }

    response = Fyber::OffersResponse.new(hashkey)

    expect { response.parse("{}", 'badsignature') }.to raise_error
  end

  it "returns a json representation of the body" do
    hashkey = double()
    allow(hashkey).to receive(:valid_response?) { true }

    body = %|{"foo": "bar"}|
    response = Fyber::OffersResponse.new(hashkey)
    json = response.parse(body, 'goodsignature')

    expect(json['foo']).to eq("bar")
  end
end
