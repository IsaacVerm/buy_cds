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
  validates :offer_id, presence: true
  validates :seller_name, presence: true
  validates :seller_rating, presence: true
  validates :price_euro, presence: true
  validates :shipping_location, presence: true
end

module SaveOffers

  def self.save_to_database(offer)
    Offer.create(offer_id: offer["id"],
                 seller_name: offer["seller_name"],
                 seller_rating: offer["seller_rating"],
                 price_euro: offer["price_euro"],
                 shipping_location: offer["shipping_location"],
                 timestamp: Time.now
                )
  end

end
