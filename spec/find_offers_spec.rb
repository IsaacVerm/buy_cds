require_relative '../lib/find_offers'

RSpec.describe FindOffers do

  find_offers = FindOffers.new(34766)

  it "opens offers page" do
    find_offers.open_offers_page(1)
  end

  context "all offers found" do

    it "returns total number of offers" do
      find_offers.open_offers_page(1)
      total = find_offers.get_total_offers

      expect(total).to be_kind_of(Numeric)
    end

    it "returns urls for all pages" do
      pending "implement get_urls_all_offers_pages"
      urls = find_offers.get_urls_all_offers_pages
    end
  end

  context "info about the offer" do
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