require 'digest/sha1'

include Digest

module Fyber
  class Hashkey
    def initialize(key)
      @key = key
    end

    def querystring(string)
      SHA1.hexdigest("#{string}&#{@key}")
    end

    def valid_response?(body, signature)
      signature === SHA1.hexdigest(body + @key)
    end
  end
end
