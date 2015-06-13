require 'sinatra'
require 'tilt/erb'
require 'json'

require_relative './lib/offers_service'


get '/' do
  erb :index
end

post '/offers' do
  now    = Time.now.to_i
  offers = OffersService.new

  @errors = []
  @offers = []

  if params["uid"].empty? || params["uid"].nil?
    @errors << :no_uid
  else
     res = offers.fetch( timestamp: now,
                         uid:   params['uid'],
                         pub0:  params['pub0'],
                         page:  params['page'] )

    @offers = res['offers']
  end

  erb :offers
end
