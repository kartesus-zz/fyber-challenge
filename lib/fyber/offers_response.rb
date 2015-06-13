require 'digest/sha1'
require 'json'

include Digest

module Fyber
  class OffersResponse
    def initialize(hashkey)
      @hashkey = hashkey
    end

    def parse(body, signature)
      raise "Invalid signature" unless @hashkey.valid_response?(body, signature)
      JSON.parse(body)
    end
  end
end
