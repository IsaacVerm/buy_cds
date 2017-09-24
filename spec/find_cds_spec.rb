require_relative '../lib/find_cds'

RSpec.describe AlbumVersionsRequest do

  context "get master version" do

    request = AlbumVersionsRequest.new("Mark Lanegan", "Bubblegum")
    response = request.get_version("master")

    it "doesn't throw any error" do
      expect(response.code).to be 200
      end
    end

    context "user agent" do
      it "includes user agent in request"
      it "can handle up to 60 request per minute"
    end
end

RSpec.describe MasterVersionResponse do

  request = AlbumVersionsRequest.new("Mark Lanegan", "Bubblegum")

  context "get master id" do


    it "returns master id" do
      response = request.get_version("master")
      master_version = MasterVersionResponse.new(response)
      master_id = master_version.get_master_id

      expect(master_id).to match(/\d+/)
    end

    it "returns an error message if it's no master id" do
      response = request.get_version("release")
      master_version = MasterVersionResponse.new(response)
      master_id = master_version.get_master_id

      expect(master_id).to eq "no master"
    end
  end

end
