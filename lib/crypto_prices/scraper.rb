class CryptoPrices::Scraper

  def scrape_url(site)

    doc = Nokogiri::HTML(open(site))
    currencies = []

    table = doc.css("tbody")

    rows = table.css("tr")

    rows.each do |coins|
      crypto_name =  coins.css("a.currency-name-container.link-secondary").text
      crypto_price = coins.css("a.price").text
    end


end
