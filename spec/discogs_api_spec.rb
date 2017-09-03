require_relative '../lib/discogs_api'

require 'rspec/expectations'

RSpec::Matchers.define :be_id_formatted do
  match do |array_of_ids|
    array_of_ids.all?{ |id| (/\d{6,8}/).match(id.to_s) } == true
  end
end

describe DiscogsAPI do

  api = DiscogsAPI.new("Tori Amos", "Little Earthquakes")
  api.get_album_info

  context "get release_ids" do
    release_ids = api.get_release_ids
    puts release_ids

    it "is an array of numbers" do
      expect(release_ids).to be_kind_of(Array)
      expect(release_ids.first).to be_kind_of(Numeric)
    end
    it "each is either 6,7 or 8 digits long" do
      expect(release_ids).to be_id_formatted
    end
    it "belongs to a cd"
    it "gets all release_ids" do
      pending("on several pages")
      fail
    end

  end

  context "get master_id" do

    it "is a number"
    it "is 5 digits long"
    it "gets all master_ids" do
      pending("on several pages")
      fail
    end

  end
end
