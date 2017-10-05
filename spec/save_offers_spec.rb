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

  bad_offers = [{"id" => "123456789",
                "seller_name" => "eurecords",
                "seller_rating" => nil,
                "price_euro" => "15.00",
                "shipping_location" => "Greece"},
               {"id" => "456796546",
                "seller_name" => nil,
                "seller_rating" => 100,
                "price_euro" => "103.00",
                "shipping_location" => "Denmark"}]

  before :each do
    Offer.delete_all
  end

  after :each do
    Offer.delete_all
  end

  it "can connect to database" do
    connected = ActiveRecord::Base.connected?
    expect(connected).to be true
  end

  context "save to database" do

    context "saved correctly" do

      before :each do
        offers.each { |offer| SaveOffers.save_to_database(offer) }
        @returned_offers = Offer.all.as_json
      end

      it "saves to database" do
        offer_ids = @returned_offers.map{ |offer| offer["offer_id"] }

        expect(offer_ids).to include "123456789","456796546"
      end

      it "timestamp field present" do
        timestamps = @returned_offers.map{ |offer| offer["timestamp"] }
        expect(timestamps).to all(match /\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2} \+\d{4}/)
      end

    end

    context "incorrect state can't be saved" do

      it "can't save the same offer twice" do
        offers.each { |offer| SaveOffers.save_to_database(offer) }
        returned_offers = Offer.all.as_json

        expect{ SaveOffers.save_to_database(offers.first) }.to raise_error(ActiveRecord::RecordNotUnique)
        expect(returned_offers.size).to be 2
      end

      it "doesn't save if not all fields are filled in" do
        SaveOffers.save_to_database(bad_offers.first)

        returned_offers = Offer.all.as_json
        expect(returned_offers.size).to be 0
      end

    end
  end
end