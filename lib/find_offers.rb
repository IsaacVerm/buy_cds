require 'bundler'
Bundler.require(:default)
require 'capybara/dsl'

class FindOffers

  include Capybara::DSL

  def initialize(master_id)
    Capybara.default_driver = :selenium
    @master_id = master_id.to_s
    @max_number_of_offers = 250
  end

  def get_offers_url(page_number)
    url = "https://www.discogs.com/sell/list?master_id=" + @master_id + "&limit=" + @max_number_of_offers.to_s + "&page=" + page_number.to_s

    return url
  end

  def open_page(page_number)
    url = get_offers_url(page_number)
    visit(url)
  end

  def get_total_offers
    total_xpath = "//*[@class='pagination_total']"

    total = first(:xpath, total_xpath).text.split(" ").last.to_i

    return total
  end

  def get_all_offers_urls
    url_first_page = get_offers_url(1)
    open_page(url_first_page)

    total = get_total_offers
    pages_left =  (total/@max_number_of_offers).floor

    page_ind = 1.step(1 + pages_left, 1).to_a

    urls = page_ind.map{ |i| get_offers_url(i) }

    return urls
  end

  def get_offers_single_page(page_number)
    open_page(page_number)

    offers = Array.new

    offer_ids = get_offer_ids

    offer_ids.each do |id|
      offer = Hash.new
      offer["id"] = id
      offers << offer
    end

    return offers

    # turn from hash of arrays into array of hashes
  end

  def get_offers_details

  end

  def open_seller_page

  end

  def get_condition
    condition_xpath = "//p[@class='item_condition']/span[3]"

    condition = all(:xpath, condition_xpath).map{ |c| c.text.strip }

    return condition
  end

  def get_seller_name

  end

  def get_seller_feedback

  end

  def get_offer_ids
    offer_ids_xpath = "//*[@class='item_description_title']"

    offer_ids = all(:xpath, offer_ids_xpath).map { |id| id[:href].split("/").last }

    return offer_ids
  end

  def price

  end

  def get_shipping_policy

  end


end

# find_offers = FindOffers.new(26600)
# find_offers.get_offers_single_page(1)