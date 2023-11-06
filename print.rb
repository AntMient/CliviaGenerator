require "colorize"
module Print
  def print_welcome
    message = <<~DELIMETER
      ###################################
      #   Welcome to Clivia Generator   #
      ###################################
    DELIMETER
    message.green
  end

  def print_bye
    puts "\e[0;34m\e[47m\Thanks for using clivia_generator!\e[m"
  end

  def cargar_datos(times = 5)
    times.times do
      sleep(1)
      print ".".cyan
    end
    puts
  end

  def loading_answer
    print "The answer was ".yellow
  end

  def correct_answer
    puts "Correct!😁".blue
  end

  def incorrect_answer(correct_answer)
    puts "#{'Incorrect!😅'.red} #{'The correct answer was'.yellow} #{correct_answer.cyan}"
  end
end
