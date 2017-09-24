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
    @response_body = JSON.parse(response.body)
  end
end

class AlbumVersionsRequest < APIRequest

  def initialize(artist,album)
    @artist = artist
    @album = album
    super()
  end

  def get_version(type)
    version = RestClient.get 'https://api.discogs.com/database/search',
                              {params: {'release_title' => @album,
                                               'artist' => @artist,
                                               'format' => 'CD',
                                               'token' => @token,
                                               'type' => type
                                                }
                                     }
    return version
  end
end

class MasterVersionResponse < APIResponse

  attr_accessor :response_body

  def initialize(response)
    super
  end

  def get_master_id
    results = @response_body["results"].first

    if results["type"] == "master"
      master_id = results["id"].to_s
    else
      master_id = "no master"
      end


    return master_id
  end

end