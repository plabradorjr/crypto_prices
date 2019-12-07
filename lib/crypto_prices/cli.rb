class CryptoPrices::CLI

  include CryptoPrices::Art

  WEBSITE = "https://coinmarketcap.com/"
  @@counter = 0

  def run
    show_welcome_spaceship
    make_crypto_objects
    if @@counter < 10
      ask_user_level1
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

  def show_complete_header
    keys = "|Rank | Name                   | Price(USD)    | Market Cap (USD)  | 24hr %Change | 24hr Volume (USD)|"
    line = "=" * (keys.length.to_i)
    puts line.colorize(:yellow)
    puts keys.colorize(:yellow)
    puts line.colorize(:yellow)
  end

  def ask_user_level1

    puts "How many cryptocurrencies would you like to see?\nI will sort them by rank.\n"
    puts "simply enter any number anywhere from" + " \"1-100\"".colorize(:green)

    input = gets.chomp

    if input.to_i > 0 && input.to_i <101
      number = input.to_i
      display_coins_without_details(number)
      ask_user_level2
    elsif input.downcase == "exit"
      austronaut
    else
      puts "not sure what that means. Here\'s a list of my commands: ".colorize(:red)
      show_commands
    end
  end

  def ask_user_level2
    puts "\nGood choice champ!\nTo see more details about a coin,"
    puts "simply enter the " + "\"rank number\"".colorize(:green) + "."
    puts "I will show you it\'s price, market cap, volume, and much more!"

    input = gets.chomp

    if input.to_i > 0 && input.to_i <101
      number = input.to_i
      display_all_coin_details(number)
      ask_user_level3
    elsif input.downcase == "exit"
      austronaut
    else
      puts "not sure what that means. Here\'s a list of my commands: ".colorize(:red)
      show_commands
    end
  end

  def ask_user_level3
    puts "\nAmazing choice boss!"
    puts "Want to see another coin with more details?"
    puts "Simply enter its\' " + "\"rank number\"".colorize(:green) + " again and I will show you more details."

    input = gets.chomp

    if input.to_i > 0 && input.to_i <101
      number = input.to_i
      display_all_coin_details(number)
      ask_user_level4
    elsif input.downcase == "exit"
      austronaut
    else
      puts "not sure what that means. Here\'s a list of my commands: ".colorize(:red)
      show_commands
    end
  end

  def ask_user_level4
    puts "\nAnother spectacular choice! You a real one!"
    puts "Keep entering a \"rank number\"" + " (1-100) ".colorize(:green) + "and I will show you more details of that certain coin."
    puts "Otherwise,\nenter " + "\"c\"".colorize(:green) + " to show other commands that I can do."
    puts "enter " + "\"exit\"".colorize(:green) + " to end program."

    input = gets.chomp

    if input.to_i > 0 && input.to_i <101
      number = input.to_i
      display_all_coin_details(number)
      ask_user_level4
    elsif input.downcase == "c"
      show_commands
    elsif input.downcase == "exit"
      austronaut
    else
      puts "not sure what that means. Here\'s a list of my commands: ".colorize(:red)
      show_commands
    end
  end

  def display_coins_without_details(input)
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

  def display_all_coin_details(input)
    show_complete_header
    number = input
    CryptoPrices::Crypto.all.each.with_index(1) do |coin, i|
      if i  == number
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

  def show_commands
    keys = "|Commands | Description                                     |"
    line = "=" * (keys.length.to_i)
    puts line.colorize(:yellow)
    puts keys.colorize(:yellow)
    puts line.colorize(:yellow)

    puts "| exit ".ljust(10, " ") + "| Will exit program".ljust(50, " ") + "|"
    puts "-" * 60
    puts "| top10 ".ljust(10, " ") + "| Will show top 10 cryptos with all details".ljust(50, " ") + "|"
    puts "-" * 60
    puts "| all ".ljust(10, " ") + "| Will show top 100 cryptos with all details".ljust(50, " ") + "|"
    puts "-" * 60
    puts "| restart ".ljust(10, " ") + "| Will refesh prices and restart program".ljust(50, " ") + "|"
    puts "-" * 60

  end

end
