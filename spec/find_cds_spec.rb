require_relative '../lib/find_cds'

# RSpec.describe AlbumVersionsRequest do
#
#   context "gets master version" do
#
#     request = AlbumVersionsRequest.new("Mark Lanegan", "Bubblegum")
#     response = request.get_master_version
#
#     it "doesn't throw any error" do
#       expect(response.code).to be 200
#       end
#     end
# end

RSpec.describe MasterVersionResponse do

  request = AlbumVersionsRequest.new("Mark Lanegan", "Bubblegum")
  response = request.get_master_version
  master_version = MasterVersionResponse.new(response)

  context "gets master id" do
    it "contains master id" do
      ap master_version
    end
  end

end
