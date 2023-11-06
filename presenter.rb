require "colorize"
module Presenter
  def menu
    get_with_options(["random", "scores", "exit"])
  end

  def get_with_options(options, required: true, default: nil)
    action = ""
    until options.include?(action)
      puts options.join(" | ").yellow
      print "> "
      action = gets.chomp
      break if action.nil? && !required

      puts "\e[0;47m\e[46m\Invalid option\e[m" unless options.include?(action)
    end
    action.nil? && default ? default : action
  end

  def sort_scores(data)
    data.sort_by { |score| score[:score] }.reverse
  end

  def scores_show
    data = JSON.parse(File.read($filename), symbolize_names: true)
    sort_scores(data)
  rescue StandardError
    []
  end

  def print_score
    table = Terminal::Table.new
    table.title = "Top Scores".blue
    table.headings = ["Name", "Score"]
    table.rows = scores_show.map do |note|
      [note[:name].to_s.yellow, note[:score].to_s.cyan]
    end
    table
  end
end
