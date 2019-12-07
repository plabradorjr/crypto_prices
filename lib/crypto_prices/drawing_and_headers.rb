module CryptoPrices::Art

  def austronaut
    puts """
                      ______________________
       .-----.       ||                     |
       /= ___  \      ||     " + "Thanks for".colorize(:green) + "      |
      |- /~~~\  |     ||      " +"checking,".colorize(:green) + "      |
     |=( '.' ) |     ||   " + "you have exited".colorize(:green) + "   |
       \__\_=_/__/     ||     " + "the program.".colorize(:green) + "    |
      {_______}      ||                     |
    /` *       `'--._||~~~~~~~~~~~~~~~~~~~~~~
   /=   [" + "HODL".colorize(:yellow) + "] .     { >
  /  /|        |`'--'||
 (    )\_______/      ||
     \``\/       \      ||
    `-| ==    \_|     ||
     /         |     ||
     |=   >\  __/     ||
      |   |- --|     ||
       |__| \___/     ||
     _{__} _{__}     ||
    (    )(    )     ||
     `---  `---  ~^^^~^^~~~^^^~^^^~^^^~^^~^

    """
  end

  def show_welcome_spaceship

    puts """
                               *     .--.
                                    / /  `
                   +               | |
                          '         \\ \\__,
                      *          +   '--'  *
                          +   /\\
             +              .'  '.   *
                    *      /======\\      +
                          ;:.  _   ;
                          |:. (_)  |
                          |:.  _   |
                +         |:. (_)  |          *
                          ;:.      ;
                        .' \\:.    / `.
                       / .-'':._.'`-. \\
                       |/    /||\\    \\|
                     _..-----````-----.._
               _.-'``                    ``'-._
             -'                                '-
    """
    puts "Welcome to my Flatiron crypto CLI project."
  end


end

module CryptoPrices::Headers

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

  def show_green_price_change
    puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:red) + "|" + " #{coin.volume}".ljust(18, " ") + "|"
    puts "-" * 102
  end

  def show_red_price_change
    puts "| #{i} ".ljust(6, " ") + "| #{coin.name}".ljust(25, " ") + "| #{coin.price}".ljust(16, " ") + "| #{coin.m_cap}".ljust(20, " ") + "|" + " #{coin.p_change}".ljust(14, " ").colorize(:green) + "|" + " #{coin.volume}".ljust(18, " ") + "|"
    puts "-" * 102
  end
end
