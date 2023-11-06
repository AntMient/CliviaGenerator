require "httparty"
require "json"
require "terminal-table"
require_relative "print"
require_relative "presenter"
require_relative "requester"
require_relative "services"

class CliviaGenerator
  include Presenter
  include Requester
  include Print

  def initialize
    @questions = []
    @userscore = 0
  end

  def start
    puts print_welcome
    action = ""
    until action == "exit"
      action = menu
      case action
      when "random" then begin
        puts cargar_datos
        ask_questions
      end
      when "scores" then print_scores
      when "exit" then print_bye
      end
    end
  end

  def random_trivia
    response = Services::Session.new.trivia_qa(10)
    response[:content][:results].each { |question| @questions << question }
    @questions
  end

  def ask_questions
    random_trivia.map do |item|
      ask_question(item)
      print ">"
      response = gets.chomp.to_i
      loading_answer
      print cargar_datos(3)
      if response == @correct
        correct_answer
        @userscore += 10
      else
        incorrect_answer(item[:correct_answer])
      end
    end
    will_save?(@userscore)
    @userscore = 0
    @questions = []
  end

  def save(names, scores)
    data = { name: names, score: scores }
    begin
      file = File.read($filename)
      scr = JSON.parse(file)
    rescue StandardError
      scr = []
    end
    scr << data
    File.write($filename, scr.to_json)
  end

  def print_scores
    puts print_score
    start
  end
end
