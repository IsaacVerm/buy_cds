require_relative '../lib/albums'

RSpec.describe Albums do

  albums = Albums.new
  html = albums.html
  list = albums.list

  it "reads the tracklist as html" do
    expect(html).to be_a_kind_of(Nokogiri::HTML::Document)
    expect(html.to_s.size).to be > 10
  end

  context "list of albums" do

      it "is a hash" do
        expect(list).to be_a_kind_of(Hash)
      end

      it "has an artist and album field" do
        expect(list.keys).to include("artist","album")
      end

      it "contains values for each field" do
        empty_element = -> (list, fields) do
          empty_fields = Array.new
          fields.each do |field|
            empty_fields << list[field].any?{ |element| element.size < 1 }
          end

          any_empty_fields = empty_fields.any? { |field| field == true }

          return any_empty_fields
        end

        expect(empty_element.call(list, ["album","artist"])).to be false
      end

      it "contains several albums" do
        expect(list["album"].size).to be > 1
        end

      it "contains no info about specific versions" do
        expect(/edition|version|remastered/).not_to match(list["album"].join)
      end
  end

  it "writes to csv" do
    albums.write_to_csv("albums.csv")

    expect(Dir.glob("albums.csv")).to include("albums.csv")

    File.delete("albums.csv")
  end

end