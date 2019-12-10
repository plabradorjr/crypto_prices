class CryptoPrices::Scraper

  def self.scrape_coinmarketcap

    doc = Nokogiri::HTML(open("https://coinmarketcap.com/"))
    currencies = []

    table = doc.css("tbody")
    rows = table.css("tr")

      rows.each do |coins|
        crypto_name =  coins.css("td.cmc-table__cell.cmc-table__cell--sticky.cmc-table__cell--sortable.cmc-table__cell--left.cmc-table__cell--sort-by__name").text
        crypto_price = coins.css("td.cmc-table__cell.cmc-table__cell--sortable.cmc-table__cell--right.cmc-table__cell--sort-by__price").text
        price_change = coins.css("td.cmc-table__cell.cmc-table__cell--sortable.cmc-table__cell--right.cmc-table__cell--sort-by__percent-change-24-h").text
        volume = coins.css("td.cmc-table__cell.cmc-table__cell--sortable.cmc-table__cell--right.cmc-table__cell--sort-by__volume-24-h").text
        market_cap = coins.css("td.cmc-table__cell.cmc-table__cell--sortable.cmc-table__cell--right.cmc-table__cell--sort-by__market-cap").text.strip

        currencies << {name: crypto_name, price: crypto_price, p_change: price_change, volume: volume, m_cap: market_cap}
      end

    currencies
  end

end
