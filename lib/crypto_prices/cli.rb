class CryptoPrices::CLI

  include CryptoPrices::Art

  WEBSITE = "https://coinmarketcap.com/"
  @@counter = 0

  def run
    welcome_spaceship
    make_crypto_objects
    if @@counter < 10
      ask_user
    end
  end

  def make_crypto_objects
    crypto_array = CryptoPrices::Scraper.scrape_url(WEBSITE)
    # sometimes nokogiri returns blank, it could be from the main website issue
    # this if-statement makes sure nokogiri re-scrapes the site if the initial
    # scrape returns blank
    if (crypto_array[0][:name] == "") && (@@counter < 10)
      @@counter += 1
      make_crypto_objects
    elsif @@counter >= 10
      puts "coinmarketcap.com has changed their webpage, edit your scraper file.".colorize(:red)
    else
    CryptoPrices::Crypto.create_objects_from_array(crypto_array)
    end
  end

  def first_level_header
    keys = "|Rank | Name                   |"
    line = "=" * (keys.length.to_i)
    puts line.colorize(:yellow)
    puts keys.colorize(:yellow)
    puts line.colorize(:yellow)
  end

  def volume_header
    keys = "|Rank | Name                   | Price(USD)    | Market Cap (USD)  | 24hr %Change | 24hr Volume (USD)|"
    line = "=" * (keys.length.to_i)
    puts line.colorize(:yellow)
    puts keys.colorize(:yellow)
    puts line.colorize(:yellow)
  end

  def ask_user

    puts "How many cryptocurrencies you would like to see?\nI will sort them by rank.\n"
    puts "simply enter any number anywhere from" + " \"1-100\"".colorize(:green)

    input = gets.chomp

    if input.to_i > 0 && input.to_i <101
      number = input.to_i
      display_more(number)
      ask_user_level2
    elsif input.downcase == "exit"
      austronaut
    else
      puts "not sure what that means, please enter a number between \"1-100\".".colorize(:red)
    end
  end

  def ask_user_level2
    puts "Good choice champ!\nTo see more details about a coin,\nsimply enter the rank number."
    puts "I will show you it\'s price, market cap, volume, and much more!"
  end

  def display_more(input)
    number = (input + 1)
    first_level_header

      CryptoPrices::Crypto.all.each.with_index(1) do |coin, i|
        if i  < number
          if coin.p_change.to_f < 0
            puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "|"
            puts "-" * 31
          else
            puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "|"
            puts "-" * 31
          end
        end
      end
  end

  def refresh_prices
    CryptoPrices::Crypto.clear_all
    @@counter = 0
    puts "\n 🚀🚀🚀🚀🚀🚀🚀🚀🚀🚀" + " prices refreshed, woot! \n".colorize(:yellow)
    CryptoPrices::CLI.new.run
  end

  def display_volume
    volume_header

    CryptoPrices::Crypto.all.each.with_index(1) do |coin, i|
      if i  < 11
        if coin.p_change.to_f < 0
          puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:red) + "|" + " #{coin.volume}".ljust(18, " ") + "|"
          puts "-" * 102
        else
          puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:green) + "|" + " #{coin.volume}".ljust(18, " ") + "|"
          puts "-" * 102
        end
      end
    end
    #ask_user_again
  end

  def ask_user_again

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
      display_more_with_volume(number)
      ask_user_again
    elsif input.downcase == "exit"
      austronaut
    elsif input.downcase == "r"
      refresh_prices
    else
      puts "not sure what that means, so the program exited.".colorize(:red)
    end
  end

  def display_more_with_volume(input)
    number = (input + 1)
    volume_header

      CryptoPrices::Crypto.all.each.with_index(1) do |coin, i|
        if i  < number
          if coin.p_change.to_f < 0
            puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:red) + "|" + " #{coin.volume}".ljust(18, " ") + "|"
            puts "-" * 102
          else
            puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:green) + "|" + " #{coin.volume}".ljust(18, " ") + "|"
            puts "-" * 102
          end
        end
      end
  end

end

#testing branch
