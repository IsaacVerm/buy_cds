require 'bundler'
Bundler.require(:default)

class TrackList

  DEFAULT_TRACKLIST_HTML_PATH = "/home/isaac/Desktop/buy_cds/lib/data/tracklist.html"

  attr_accessor :albums, :html

  def initialize
    @albums = Array.new
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

    artists.zip(albums) do |artist, album|
      pair = Hash.new
      pair["artist"] = artist
      pair["album"] = album
      @albums << pair
    end

  end

end