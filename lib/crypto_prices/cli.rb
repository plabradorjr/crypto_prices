class CryptoPrices::CLI

  include CryptoPrices::Art
  include CryptoPrices::Headers

  def run
    show_welcome_spaceship
    make_crypto_objects
    ask_user_level1
  end

  def make_crypto_objects
    crypto_array = CryptoPrices::Scraper.scrape_coinmarketcap
    CryptoPrices::Crypto.create_objects_from_array(crypto_array)
  end

  def ask_user_level1
    puts "How many cryptocurrencies would you like to see?\nI will sort them by rank.\n"
    puts "simply enter any number anywhere from" + " \"1-100\"".colorize(:green)

    input = gets.chomp
    show_coin_ranks(input)
  end

  def ask_user_level2
    puts "\nGood choice!"
    puts "Enter the coin \"rank number\"" + " (1-100) ".colorize(:green) + "and I will show you the price, 24Hr percent change, and more."
    puts "Otherwise,\nenter " + "\"c\"".colorize(:green) + " to show other commands that I can do."
    puts "enter " + "\"exit\"".colorize(:green) + " to end program."

    input = gets.chomp
    show_coin_ranks_and_details(input)
  end

  def show_coin_ranks(input)
    if input.to_i > 0 && input.to_i < CryptoPrices::Crypto.all.length
      number = input.to_i
      display_coins_without_details(number)
      ask_user_level2
    else
      ask_user_conditions(input)
    end
  end

  def show_coin_ranks_and_details(input)
    if input.to_i > 0 && input.to_i <= CryptoPrices::Crypto.all.length
      number = input.to_i
      display_all_coin_details(number)
      ask_user_level2
    else
      ask_user_conditions(input)
    end
  end

  def display_coins_without_details(input)
    number = (input + 1)
    first_level_header

      CryptoPrices::Crypto.all.each.with_index(1) do |coin, i|
        if i  < number
            puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "|"
            puts "-" * 31
        end
      end
  end

  def refresh_and_restart_program
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
    keys = "|Commands | Description                                                                |"
    line = "=" * (keys.length.to_i)
    puts line.colorize(:yellow)
    puts keys.colorize(:yellow)
    puts line.colorize(:yellow)


    puts "| top10 ".ljust(10, " ") + "| Will show top 10 cryptos with all details".ljust(77, " ") + "|"
    puts "-" * 87
    puts "| all ".ljust(10, " ") + "| Will show top 100 cryptos with all details".ljust(77, " ") + "|"
    puts "-" * 87
    puts "| restart ".ljust(10, " ") + "| Will refesh prices and restart program".ljust(77, " ") + "|"
    puts "-" * 87
    puts "| 1-100 ".ljust(10, " ") + "| Entering a number between 1-100 will show that many cryptos sorted by rank".ljust(77, " ") + "|"
    puts "-" * 87
    puts "| c ".ljust(10, " ") + "| Will show commands".ljust(77, " ") + "|"
    puts "-" * 87
    puts "| exit ".ljust(10, " ") + "| Will exit program. Entering \'x\' will work the same".ljust(77, " ") + "|"
    puts "-" * 87

    input = gets.chomp

    ask_user_conditions(input)
  end

  def ask_user_conditions(input)
    if input.downcase == "c"
      show_commands
    elsif input.to_i > 0 && input.to_i <= CryptoPrices::Crypto.all.length
      number = input.to_i
      display_coins_without_details(number)
      ask_user_level2
    elsif input.downcase == "exit" || input.downcase == "x"
      austronaut
    elsif input.downcase == "top10"
      top10
    elsif input.downcase == "all"
      show_all_crypto_with_all_details
    elsif input.downcase == "restart"
      refresh_and_restart_program
    else
      puts "Entry not recognized. Here\'s a list of my commands: ".colorize(:red)
      show_commands
    end
  end

  def show_all_crypto_with_all_details
    show_complete_header
    CryptoPrices::Crypto.all.each.with_index(1) do |coin, i|
      if i  < 101
        if coin.p_change.to_f < 0
          puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:red) + "|" + " #{coin.volume}".ljust(18, " ") + "|"
          puts "-" * 102
        else
          puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:green) + "|" + " #{coin.volume}".ljust(18, " ") + "|"
          puts "-" * 102
        end
      end
    end
    puts "\nWoah! Now you got all the details!"
    puts "enter \"c\" to show commands."
    puts "enter \"x\" to exit program."
    input = gets.chomp

    if input.downcase == "y"
      refresh_and_restart_program
    elsif input.downcase == "n"
      puts "\nOK, what would you like to do?"
      puts "Here are my available commands:"
      show_commands
    else
      ask_user_conditions(input)
    end  end

  def top10
    show_complete_header
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
    puts "\nWould you like to show all 100 coins? (y/n)"
    input = gets.chomp

    if input.downcase == "y"
      show_all_crypto_with_all_details
    elsif input.downcase == "n"
      puts "\nOK, what would you like to do?"
      puts "Here are my available commands:"
      show_commands
    else
      ask_user_conditions(input)
    end
  end

end
