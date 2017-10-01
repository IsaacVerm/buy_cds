require 'bundler'
Bundler.require(:default)
require 'capybara/dsl'

class FindOffers

  include Capybara::DSL

  def initialize(master_id)
    Capybara.default_driver = :selenium
    @master_id = master_id.to_s
    @max_number_of_offers = 100
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

    ids = get_offer_ids
    sleeve_condition = get_sleeve_condition
    names = get_seller_names
    ratings = get_seller_ratings
    prices = get_prices
    shipping_locations = get_shipping_locations

    ids.zip(sleeve_condition, names, ratings, prices, shipping_locations) do |id, sleeve_condition, name, rating, price, shipping_location|
      offer = Hash.new
      offer["id"] = id
      offer["seller_name"] = name
      offer["seller_rating"] = rating
      offer["price_euro"] = price
      offer["shipping_location"] = shipping_location
      offers << offer
    end

    return offers
  end

  def get_offer_ids
    xpath = "//*[@class='item_description_title']"

    ids = all(:xpath, xpath).map { |id| id[:href].split("/").last }

    return ids
  end

  def get_sleeve_condition
    xpath = "//*[@class='item_sleeve_condition']"
    code_regex = /\(.+\)/

    condition = all(:xpath, xpath).map do |c|
       full_text = c.text
       code = full_text.scan(code_regex).first.gsub(/\(|\)/, "")
       code = "M-" if code == "NM or M-"
       code
    end

    return condition
  end

  def get_media_condition
    xpath = "//p[@class='item_condition']/span[3]"
    code_regex = /\(.+\)/

    condition = all(:xpath, xpath).map do |c|
      full_text = c.text
      code = full_text.scan(code_regex).first.gsub(/\(|\)/, "")
      code = "M-" if code == "NM or M-"
      code
    end

    return condition
  end

  def get_seller_names
    xpath = "//*[@class='seller_info']/ul/li[1]//a"

    names = all(:xpath, xpath).map{ |name| name.text }

    return names
  end

  def get_seller_ratings
    xpath = "//*[@class='seller_info']/ul/li[2]//strong"

    rating = all(:xpath, xpath).map{ |r| r.text.gsub('%','').to_f }

    return rating
  end

  def get_prices
    xpath_original_prices = "//*[@class='item_price hide_mobile']/span[@class='price']"
    xpath_converted_prices = "//*[@class='converted_price']"

    original_prices = all(:xpath, xpath_original_prices).map { |price| price.text }
    converted_prices = all(:xpath, xpath_converted_prices).map { |price| price.text }

    # find ind of converted prices
    ind_foreign_currency_in_original_prices = Array.new

    original_prices.each_with_index do |price, i|
      price_in_euro = price.include?("€")
      ind_foreign_currency_in_original_prices << i if !price_in_euro
      end

    # change ind to converted prices
    prices = original_prices

    ind_foreign_currency_in_original_prices.zip(converted_prices) do |ind, price|
      prices[ind] = price
    end

    # remove euro symbol and about
    price_regex = /\d{1,3}\.\d{2}/
    prices.map! do |price|
      price_without = price.scan price_regex
      price_without.first
    end

    return prices
  end

  def get_shipping_locations
    xpath = "//*[text()='Ships From:']/.."

    locations = all(:xpath, xpath).map{ |location| location.text.gsub("Ships From:","") }

    return locations
  end

  # def get_shipping_policies
  #   xpath_policy_link = "//td[@class='item_price hide_mobile']//a[@class='show-terms-link']"
  #   xpath_policy = "//div[@class='react-modal ']"
  #
  # end


end

find_offers = FindOffers.new(26600)
offers = find_offers.get_offers_single_page(1)
find_offers.get_shipping_locations