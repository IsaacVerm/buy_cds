require 'bundler'
Bundler.require(:default)

class Search

  attr_accessor :album_info, :basic_info

  def initialize(artist,album)
    @artist = artist
    @album = album
    @token = "rFHDuivLsUQCoHPxlKzPKKsjdBqJtYJMKxMsqAJG"
  end

  def get_album_info
    response = RestClient.get 'https://api.discogs.com/database/search',
                              {params: {'release_title' => @album,
                                        'artist' => @artist,
                                        'token' => @token}
                              }
    @album_info = JSON.parse(response.body)
  end

  def extract_basic_info
    @basic_info = Hash.new
    @basic_info["title"] = @album_info["results"].map { |version| version["title"] }
    @basic_info["id"] = @album_info["results"].map { |version| version["id"] }
  end
end