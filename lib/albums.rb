require 'bundler'
Bundler.require(:default)
require 'csv'
require_relative('./buy_cds')

class Albums

  include BuyCds

  attr_accessor :html, :list

  def initialize
    @html = read_as_html

    raw_list = extract_album_info(@html)
    @list = clean_album_info(raw_list)
  end

  def read_as_html
    Nokogiri::HTML(open(BuyCds::PROJECT_PATH + 'lib/data/tracklist.html'))
  end

  def extract_album_info(html)
    xpath_artists = "//span[@class = 'artists-album ellipsis-one-line']/span[1]/span/a"
    xpath_albums = "//a[contains(@href,'album')]"

    artists = html.xpath(xpath_artists).map{ |node| node.text }
    albums = html.xpath(xpath_albums).map{ |node| node.text }

    list = Hash.new
    list["artist"] = artists
    list["album"] = albums

    return list
  end

  def clean_album_info(list)
    list["album"].map!{ |album| album.gsub(/\([^)]*\)|\[[^\]]*\]/,"").strip }

    return list
  end

  def write_to_csv(filename)

    Dir.chdir(BuyCds::PROJECT_PATH + "lib/data")

    CSV.open(filename, "wb", encoding: 'ISO-8859-1') do |csv|
      csv << ["artist","album"]

      @list["artist"].zip(@list["album"]) do |artist, album|
        csv << [artist, album]
      end
    end
  end

end