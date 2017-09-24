require 'bundler'
Bundler.require(:default)

class APIRequest
  def initialize
  @token = "cKhZpCHFAkVvNsNUKWyiwBvYZKHOzcLYhrYbbadr"
  @user_agent = "BuyCds: project to find sellers cds; isaacverm@gmail.com"
  end
end

class APIResponse
  def initialize(response)
    @response = JSON.parse(response.body)
  end
end

class ScrapeRequest
end

class ScrapeResponse
end

class AlbumVersionsRequest < APIRequest

  attr_accessor :master_version

  def initialize(artist,album)
    @artist = artist
    @album = album
    super()
  end

  def get_master_version
    master_version = RestClient.get 'https://api.discogs.com/database/search',
                              {params: {'release_title' => @album,
                                               'artist' => @artist,
                                               'format' => 'CD',
                                               'token' => @token,
                                               'type' => 'master'
                                                }
                                     }
    return master_version
  end
end

class MasterVersionResponse < APIResponse

  def initialize(master_version)
    super
    ap @master_version
  end

  def get_master_id
    master_id = @master_version
  end

end