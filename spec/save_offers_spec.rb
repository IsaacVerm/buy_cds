require_relative '../lib/save_offers'

RSpec.describe SaveOffers do

  offers = [{"id" => "123456789",
             "seller_name" => "eurecords",
             "seller_rating" => 99.1,
             "price_euro" => "15.00",
             "shipping_location" => "Greece"},
            {"id" => "456796546",
             "seller_name" => "JMS-Music",
             "seller_rating" => 100,
             "price_euro" => "103.00",
             "shipping_location" => "Denmark"}]

  context "correctness check" do

    it "checks if all fields are filled in for each offer"
    it "doesn't add the field if not all fields are filled in"
  end

  context "database connection" do
    it "connects"
  end

  context "adding data" do
    it "timestamp field is added"
    it "data can only be added" do
      SaveOffers.new(offers[0])
    end
  end
end