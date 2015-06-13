require 'offers_request'

RSpec.describe Fyber::OffersRequest do
  context "querystring" do
    it "returns default data ordered alphabetically" do
      default = { b: 2, a: 1 }
      o = Fyber::OffersRequest.new(default)
      expect(o.querystring).to eq("a=1&b=2")
    end

    it "returns default data + parameters ordered alphabetically" do
      default = { c: 3, a: 1 }
      o = Fyber::OffersRequest.new(default)
      expect(o.querystring({ b: 2 })).to eq("a=1&b=2&c=3")
    end
  end

  context "signed_querystring" do
    it "adds hashkey param to the end of the querystring" do
      hashkey = double()
      allow(hashkey).to receive(:querystring) { '123' }

      o = Fyber::OffersRequest.new({})
      expect(o.signed_querystring({ a: 1 }, hashkey)).to eq("a=1&hashkey=123")
    end
  end

end
