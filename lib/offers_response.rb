require 'digest/sha1'
require 'json'

include Digest

module Fyber
  class OffersResponse
    def initialize(api_key)
      @api_key = api_key
    end

    def parse(body, signature)
      raise "Invalid signature" if SHA1.hexdigest(body + @api_key) != signature
      JSON.parse(body)
    end
  end
end
