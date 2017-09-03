require_relative '../lib/discogs_scrape'

describe DiscogsScrape do

  scrape = DiscogsScrape.new("64690")

  context "it gives information about the listing" do

    context "album" do
    it "price"
    it "condition"
    end

    context "seller" do
    it "name"
    it "location"
    end

    it "shipping terms"

  end

  it "saves listing information to file"
end
