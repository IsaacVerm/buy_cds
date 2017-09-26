require_relative '../lib/find_offers'

RSpec.describe FindOffers do

  find_offers = FindOffers.new(26600)

  context "opening offer pages" do

    it "creates url of offer page" do
      url = find_offers.get_offers_url(1)
      expect(url).to eq("https://www.discogs.com/sell/list?master_id=26600&limit=250&page=1")
    end

    it "opens offers page" do
      find_offers.open_page(1)
    end

    context "all offers found" do

      it "returns total number of offers" do
        find_offers.open_page(1)
        total = find_offers.get_total_offers

        expect(total).to be_kind_of(Numeric)
      end

      it "returns urls for all pages" do
        urls = find_offers.get_all_offers_urls

        urls_regex = /https:\/\/www.discogs.com\/sell\/list\?master_id=26600&limit=250&page=\d/

        expect(urls).to all(match urls_regex)
      end
    end
  end

  context "info about the offer" do
    # offers = find_offers.get_offers_single_page(1)
    offers = [{"id" => "123456789",
               "sleeve_condition" => "VG+",
               "media_condition" => "VG+",
               "seller_name" => "eurecords",
               "seller_rating" => 99.1,
               "price_euro" => "15.00",
               "shipping_policy" => "PAYPAL ACCEPTED ONLY!",
               "shipping_location" => "Greece",
               "year" => "2012"},
              {"id" => "456796546",
               "sleeve_condition" => "M",
               "media_condition" => "M",
               "seller_name" => "JMS-Music",
               "seller_rating" => 100,
               "price_euro" => "103.00",
               "shipping_policy" => "PAYPAL NOT ACCEPTED!",
               "shipping_location" => "Denmark",
               "year" => "1999"}]

    context "offers" do

      it "is an array" do
        expect(offers).to be_kind_of(Array)
      end

      it "each offer being a hash" do
        expect(offers).to all(be_kind_of(Hash))
      end

      it "each offer has several attributes" do
        expected_offer_attributes = ["id", "sleeve_condition", "media_condition", "seller_name",
                                     "seller_rating", "price_euro", "shipping_policy", "shipping_location", "year"]

        offers.each_with_index do |offer, i|
          expect(offer.keys).to match_array(expected_offer_attributes),
                                "Expected: #{expected_offer_attributes},
                                        Got :#{offers[i].keys}, failed at offer having id #{offers[i]["id"]}"
        end
      end

    end

    it "offer id" do
      offers.each do |offer|
        expect(offer["id"]).to match /\d{9}/
      end
    end

    context "condition" do
      conditions = ["M","M-","VG+","VG","G+","F"]

      it "sleeve" do
        offers.each do |offer|
          expect(conditions).to include offer["sleeve_condition"]
        end
      end

      it "media" do
        offers.each do |offer|
          expect(conditions).to include offer["media_condition"]
        end
      end
    end

    context "seller" do

      it "name" do
        offers.each do |offer|
          expect(offer["seller_name"]).not_to be_nil
        end
      end

      it "rating" do
        offers.each do |offer|
          rating = offer["seller_rating"]
          expect(rating).to be >= 0
          expect(rating).to be <= 100
        end
      end
    end

    context "shipping" do

      it "location" do
        offers.each do |offer|
          expect(offer["shipping_location"]).not_to be_nil
        end
      end

      it "policy" do
        offers.each do |offer|
          expect(offer["shipping_policy"]).not_to be_nil
        end
      end

    end

    it "price in euro" do
      offers.each do |offer|
        expect(offer["price_euro"]).to match /\d{2}\.\d{2}/
      end
    end

    it "year" do
      offers.each do |offer|
        expect(offer["year"]).to match /\d{4}/
      end
    end

  end
end