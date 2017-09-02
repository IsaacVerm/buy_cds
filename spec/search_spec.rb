require_relative '../lib/search'

describe Search do

  search = Search.new("Tori Amos", "Little Earthquakes")
  search.get_album_info
  ap search.album_info

  context "get list of album versions" do

    it "is a hash" do
      expect(search.album_info).to be_a_kind_of(Hash)
    end
    it "contains title and id" do
      search.extract_basic_info

      pending("create expectation for basic info")
      fail
    end

  end

  it "extracts title and id"

  it "filters out versions lacking basic info"

end