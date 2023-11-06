require "json"
require "httparty"
require "htmlentities"
require "colorize"

module Requester
  def ask_question(item)
    coder = HTMLEntities.new
    puts "#{'Category'.light_green}: #{item[:category].light_cyan}"
    puts "#{'Question'.light_green}: #{coder.decode(item[:question].light_magenta)}"
    toptions = []
    toptions << item[:correct_answer] << item[:incorrect_answers]
    toptions.flatten!
    num = 0
    options_random = []
    @correct = 0
    toptions.shuffle.each do |option|
      options_random.push({ num: num += 1, option: option })
      @correct = num if option == item[:correct_answer]
    end

    options_random.each_with_index do |element, index|
      puts "#{(index + 1).to_s.cyan}. #{coder.decode(element[:option].yellow)}"
    end
  end

  def will_save?(score)
    puts <<~DELIMETER
      Well done! Your score is #{score}
      --------------------------------------------------
      Do you want to save your score? (y/n)
    DELIMETER
    options = ["y", "n"]
    response = ""
    until options.include?(response)
      response = gets.chomp.downcase
      puts "Invalid option" unless options.include?(response)
    end
    return unless response == "y"

    puts "Type the name to assign to the score"
    name = gets.chomp
    name = "Anonymous" if name == ""
    save(name, score)
  end
end
