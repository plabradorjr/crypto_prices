class CLI

  def run
    make_crypto_objects
    display_top10
    ask_user
    # add method to ask user input to show more details
      ## ask_user
    # add another method to exit
  end

  def make_crypto_objects
    crypto_array = Scraper.scrape_url("https://coinmarketcap.com/")
    Crypto.create_objects_from_array(crypto_array)
  end

  def display_top10
    header

      Crypto.all.each.with_index(1) do |coin, i|
        if i  < 11
        l = "| #{i}  | #{coin.name} | #{coin.price} |"
        puts l
        puts "-"*(l.length.to_i)
        end
      end
  end

  def header
    keys = "|Rank| Coin    | Price(USD) |"
    puts "=" * (keys.length.to_i)
    puts keys.colorize(:blue)
    puts "=" * (keys.length.to_i)
  end

  def all_header
    keys = "|Rank| Coin    | Price(USD) | Market Cap (USD)  | 24 Hr Volume | 24hr %Change |"
    puts "=" * (keys.length.to_i)
    puts keys
    puts "=" * (keys.length.to_i)
  end

  def ask_user
    puts """
    Want to see more details?

    enter \"yes\" to show market cap, volume, and 24hr % price change
    enter \"100\" to show top 100 crypto with all details
    enter \"exit\" to end program
    """

    input = gets.chomp.upcase

    if input == "YES"
      display_more_details
    else

      puts input
    end

  end

  def display_more_details
    all_header

      Crypto.all.each.with_index(1) do |coin, i|
        if i  < 11
        l = "| #{i}  | #{coin.name} | #{coin.price} | #{coin.m_cap} | #{coin.volume} | #{coin.p_change} |"
        puts l
        puts "-"*(l.length.to_i)
        end
      end
  end

end
