require 'bundler'
Bundler.require(:default)

class DiscogsAPI

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

  def get_release_ids
    @release_id = @album_info["results"].map { |version| version["id"] }
  end

end