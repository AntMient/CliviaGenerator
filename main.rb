require_relative "clivia_generator"

$filename = ARGV.shift || "scores.json"
trivia = CliviaGenerator.new
trivia.start
