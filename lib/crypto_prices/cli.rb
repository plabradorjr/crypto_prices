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
    all_header

      Crypto.all.each.with_index(1) do |coin, i|
        if i  < 11
          if coin.p_change.to_f < 0
            puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(18, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:red) + "|"
            puts "-" * 76
          else
            puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(18, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:green) + "|"
            puts "-" * 76
          end
        end
      end
  end

  def all_header
    keys = "|Rank | Name            | Price(USD)    | Market Cap (USD)  | 24hr %Change |"
    line = "=" * (keys.length.to_i)
    puts line.colorize(:yellow)
    puts keys.colorize(:yellow)
    puts line.colorize(:yellow)
  end

  def ask_user

    puts " "
    puts "\t Want to see more cryptocurrencies?"
    puts "\t enter a number between " + "\"1 - 100\"".colorize(:green)
    puts "\t I can show you up to 100 coins."
    puts " "
    puts "\t enter " + "\"r\"".colorize(:green) + " to refresh the prices"
    puts " "
    puts "\t enter " + "\"exit\"".colorize(:green) + " to end program"

    input = gets.chomp

    if input.to_i > 0 && input.to_i <101
      number = input.to_i
      display_more(number)
      ask_user
    elsif input.downcase == "exit"
      puts "Thanks for checking. You have exited the program.".colorize(:green)
    elsif input.downcase == "r"
      refresh_prices
    else
      puts "not sure what that means, so the program exited.".colorize(:red)
    end
  end

  def display_more(input)
    number = (input + 1)
    all_header

      Crypto.all.each.with_index(1) do |coin, i|
        if i  < number
          if coin.p_change.to_f < 0
            puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(18, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:red) + "|"
            puts "-" * 76
          else
            puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(18, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:green) + "|"
            puts "-" * 76
          end
        end
      end
  end

  def refresh_prices
    Crypto.clear_all

    puts " prices refreshed, yay! ".colorize(:yellow)
    puts "🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀"
    puts " "
    CLI.new.run
  end
end
