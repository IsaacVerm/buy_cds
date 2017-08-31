require_relative '../lib/albums'

RSpec.describe Albums do

  context "new list of albums" do
    list = Albums.new.list

    it "is a hash" do
      expect(list).to be_a_kind_of(Hash)
    end
    it "is empty" do
      expect(list).to be_empty
    end

  end

  it "reads the tracklist as html" do
    html = Albums.new.html
    expect(html).to be_a_kind_of(Nokogiri::HTML::Document)
    expect(html.to_s.size).to be > 10
  end

  context "adding artist and album info to list" do
    albums = Albums.new
    albums.add_album_info
    list = albums.list

    it "has an artist and album field" do
      expect(list.keys).to include("artist","album")
    end
    it "contains values for each field" do
      pending("make it work for all fields")
      
      nr_char = list["artist"].map{ |artist| artist.size }
      expect(nr_char).to all( be > 0)

      fail
    end

    it "contains several albums"

  end
  it "writes tracklist to csv"

end