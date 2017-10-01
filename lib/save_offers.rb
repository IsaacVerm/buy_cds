require 'bundler'
Bundler.require(:default)
require 'active_record'

ActiveRecord::Base.establish_connection(
    :adapter => 'mysql2',
    :database => 'offers',
    :username => 'root',
    :password => 'bed303',
    :host => "localhost",
    :port => 3306)

class Offer < ActiveRecord::Base
end

class SaveOffers

  def initialize(offer)
    @offer = offer
    save_to_database
  end

  def save_to_database
    Offer.create(id: @offer["id"],
                seller_name: @offer["seller_name"],
                seller_rating: @offer["seller_rating"],
                price_euro: @offer["price_euro"],
                shipping_location: @offer["shipping_location"]
    )
  end
end
