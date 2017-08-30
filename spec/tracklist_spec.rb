require_relative '../lib/tracklist'

RSpec.describe TrackList do

  context "new list of albums" do
    albums = TrackList.new.albums

    it "is an array" do
      expect(albums).to be_a_kind_of(Array)
    end
    it "is empty" do
      expect(albums).to be_empty
    end

  end

  context "html tracklist" do
    html = TrackList.new.html

    it "is read in as html" do
      expect(html).to be_a_kind_of(Nokogiri::HTML::Document)
      expect(html.to_s.size).to be > 10
    end

    context "list of albums" do
      tracklist = TrackList.new
      tracklist.add_album_info
      albums = tracklist.albums

      it "gives info about artist and album" do
        puts albums
      end
      it "isn't empty"
    end

  end

  it "writes tracklist to csv"

end