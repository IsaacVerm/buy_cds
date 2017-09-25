require_relative '../lib/find_offers'

RSpec.describe FindOffers do

  find_offers = FindOffers.new(26600)

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

  context "info about the offer" do
    context "offers details" do
      offers_details = find_offers.get_offers_details_page(1)

      it "is an array" do
        expect(offers_details).to be_kind_of(Array)
      end
      it "of hashes" do
        expect(offers_details).to all(be_kind_of(Hash))
      end
      it "detailing offer id, condition, seller, price and shipping policy" do
        expect(offers_details).to all( include "offer_id", "sleeve_condition")
      end
    end

    it "offer id"

    context "condition" do
      it "sleeve"
      it "media"
    end

    context "seller" do
      it "name"
      it "feedback"
    end

    it "price"
    it "shipping policy"
  end
end