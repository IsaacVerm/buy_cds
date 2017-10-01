require 'bundler'
Bundler.require(:default)

class Offer < ApplicationRecord
end

# offers = [{"id" => "123456789",
#            "sleeve_condition" => "VG+",
#            "media_condition" => "VG+",
#            "seller_name" => "eurecords",
#            "seller_rating" => 99.1,
#            "price_euro" => "15.00",
#            "shipping_policy" => "PAYPAL ACCEPTED ONLY!",
#            "shipping_location" => "Greece",
#            "year" => "2012"},
#           {"id" => "456796546",
#            "sleeve_condition" => "M",
#            "media_condition" => "M",
#            "seller_name" => "JMS-Music",
#            "seller_rating" => 100,
#            "price_euro" => "103.00",
#            "shipping_policy" => "PAYPAL NOT ACCEPTED!",
#            "shipping_location" => "Denmark",
#            "year" => "1999"}]


offer = Offer.new
offer.seller_name = "John Doe"
puts offer.seller_name