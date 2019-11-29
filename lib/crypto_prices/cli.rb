class CLI

  # WEBSITE = "https://coinmarketcap.com/"

  def run
    header
    make_crypto_objects
    display_top10
    # add method to ask user input to show more details
      ## make_crypto_objects
    # add method to display objects
      ## display_table
    # add another method to exit
  end

  def make_crypto_objects
    crypto_array = Scraper.scrape_url("https://coinmarketcap.com/")
    Crypto.create_objects_from_array(crypto_array)
  end

  def display_top10

      Crypto.all.each.with_index(1) do |coin, i|
        if i  < 11
        l = "| #{i}  | #{coin.name} | #{coin.price} |"
        puts l
        puts "-"*(l.length.to_i)
        end

      end

  end

  def header
    bar = "="*31
    puts bar
    puts "|Rank| Coin    | Price (USD) |"
    puts bar
  end

end
