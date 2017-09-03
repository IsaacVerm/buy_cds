require 'bundler'
Bundler.require(:default)
require'csv'

class Albums

  DEFAULT_TRACKLIST_HTML_PATH = "/home/isaac/Desktop/buy_cds/lib/data/tracklist.html"

  attr_accessor :list, :html

  def initialize
    @list = Hash.new
    @html = read_as_html
  end

  def read_as_html
    Nokogiri::HTML(open(DEFAULT_TRACKLIST_HTML_PATH))
  end

  def add_album_info
    xpath_artists = "//span[@class = 'artists-album ellipsis-one-line']/span[1]/span/a"
    xpath_albums = "//a[contains(@href,'album')]"

    artists = @html.xpath(xpath_artists).map{ |node| node.text }
    albums = @html.xpath(xpath_albums).map{ |node| node.text }

    @list["artist"] = artists
    @list["album"] = albums
  end

  def clean_album_info
    @list["album"] = @list["album"].map{ |album| album.gsub(/\([^)]*\)|\[[^\]]*\]/,"").strip }
  end

  def write_to_csv(filename)

    Dir.chdir(File.dirname(__FILE__) + "/data")

    CSV.open(filename, "wb", encoding: 'ISO-8859-1') do |csv|
      csv << ["artist","album"]

      @list["artist"].zip(@list["album"]) do |artist, album|
        csv << [artist, album]
      end
    end
  end

end