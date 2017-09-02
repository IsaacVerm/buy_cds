require_relative '../lib/albums'

RSpec.describe Albums do

  it "reads the tracklist as html" do
    html = Albums.new.html
    expect(html).to be_a_kind_of(Nokogiri::HTML::Document)
    expect(html.to_s.size).to be > 10
  end

  context "list of albums" do

    context "new list of albums" do
      list = Albums.new.list

      it "is a hash" do
        expect(list).to be_a_kind_of(Hash)
      end
      it "is empty" do
        expect(list).to be_empty
      end

    end

    context "adding artist and album info" do
      albums = Albums.new
      albums.add_album_info
      list = albums.list

      it "list has an artist and album field" do
        expect(list.keys).to include("artist","album")
      end
      it "list contains values for each field" do
        pending("values calculated but not used in expectation")

        values = Array.new
        values = list.keys { |field| values =+ list[field] }

        nr_char = list["artist"].map{ |artist| artist.size }
        expect(nr_char).to all( be > 0)

        fail
      end
      it "contains several albums" do
        expect(list["album"].size).to be > 1
      end

    end

    context "cleaning added info" do
      albums = Albums.new
      albums.add_album_info
      albums.clean_album_info
      list = albums.list

      it "album contains no info about specific versions" do
        expect(/edition|version|remastered/).not_to match(list["album"].join)
      end
    end

  end

  it "writes to csv" do
    albums = Albums.new
    albums.add_album_info
    albums.clean_album_info
    albums.write_to_csv("albums.csv")

    expect(Dir.glob("albums.csv")).to include("albums.csv")

    File.delete("albums.csv")
  end

end