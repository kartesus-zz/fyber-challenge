require_relative './lib/offers_service'

now = Time.now.to_i

offers = OffersService.new
json = offers.fetch( timestamp: now, uid: 'player1', pub0: 'campaign2', page: 1)

puts json
