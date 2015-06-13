module Fyber
  class OffersRequest
    def initialize(base)
      @base = base
    end

    def querystring(data={})
      @base.merge(data)
           .sort
           .reduce([]) {|qs, (k, v)| qs << "#{k}=#{v}" }
           .join('&')
    end

    def signed_querystring(data, hashkey)
      qs = querystring(data)
      "#{qs}&hashkey=#{hashkey.querystring(qs)}"
    end
  end
end
