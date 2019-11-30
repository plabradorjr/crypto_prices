class CLI

  WEBSITE = "https://coinmarketcap.com/"

  def run
    make_crypto_objects
    display_top10
    ask_user
  end

  def make_crypto_objects
    crypto_array = Scraper.scrape_url(WEBSITE)
    # sometimes nokogiri returns blank, it could be from the main website issue
    # this if-statement makes sure nokogiri re-scrapes the site if the initial
    # scrape returns blank
    if crypto_array[0][:name] == ""
      make_crypto_objects
    else
    Crypto.create_objects_from_array(crypto_array)
    end
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
    line = "=" * (keys.length.to_i)
    puts line.colorize(:green)
    puts keys.colorize(:green)
    puts line.colorize(:green)
  end

  def all_header
    keys = "|Rank| Coin    | Price(USD) | Market Cap (USD) | 24hr %Change |"
    line = "=" * (keys.length.to_i)
    puts line.colorize(:green)
    puts keys.colorize(:green)
    puts line.colorize(:green)
  end

  def ask_user
    puts """
    Want to see more cryptocurrencies?
    I can show you up to 100 coins,
    simply enter a number between \"1 - 100\".

    enter \"exit\" to end program
    """

    input = gets.chomp.to_i

    if input != "exit"
      display_more(input)
      ask_user
    else
      puts "Thanks for checking. You have exited the program."
    end

  end

  def display_more_details
    all_header

      Crypto.all.each.with_index(1) do |coin, i|
        if i  < 11
        l = "| #{i}  | #{coin.name} | #{coin.price} | #{coin.m_cap} | #{coin.p_change} |"
        puts l
        puts "-"*(l.length.to_i)
        end
      end
  end

  def display_100
    all_header

      Crypto.all.each.with_index(1) do |coin, i|
        l = "| #{i}  | #{coin.name} | #{coin.price} | #{coin.m_cap} | #{coin.p_change} |"
        puts l
        puts "-"*(l.length.to_i)
      end
  end

  def display_more(input)
    number = (input + 1)
    all_header

      Crypto.all.each.with_index(1) do |coin, i|
        if i  < number
        l = "| #{i}  | #{coin.name} | #{coin.price} | #{coin.m_cap} | #{coin.p_change} |"
        puts l
        puts "-"*(l.length.to_i)
        end
      end

  end


end
