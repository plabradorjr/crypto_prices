class Scraper

  def self.scrape_url(site)

    doc = Nokogiri::HTML(open(site))
    currencies = []

    table = doc.css("tbody")
    rows = table.css("tr")

      rows.each do |coins|
        crypto_name =  coins.css("a.currency-name-container.link-secondary").text
        crypto_price = coins.css("a.price").text
        price_change = coins.css("td.no-wrap.percent-change").text
        volume = coins.css("a.volume").text
        market_cap = coins.css("td.no-wrap.market-cap.text-right").text.strip

        currencies << {name: crypto_name, price: crypto_price, p_change: price_change, volume: volume, m_cap: market_cap}
      end

    currencies
  end

end
