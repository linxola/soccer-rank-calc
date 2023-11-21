# frozen_string_literal: true

require_relative '../lib/scoreboard'

# Class that calculates the soccer league's ranking table
# based on a file with games results
class Calculator
  def initialize
    @game_results = ARGF.read
    @scoreboard = Scoreboard.new
  end

  def run
    @game_results.each_line do |line|
      parsed_line = parse_line(line)
      calculate_scoreboard(parsed_line[:teams], parsed_line[:scores])
    end

    @scoreboard.print_ranking
  end

  private

  def parse_line(line)
    team_scores = line.chomp.split(',')
    teams = [
      team_scores[0].split(/\d/)[0].strip,
      team_scores[1].split(/\d/)[0].strip
    ]
    scores = [team_scores[0].split.last, team_scores[1].split.last]

    { teams:, scores: }
  end

  def calculate_scoreboard(teams, scores)
    if scores[0] > scores[1]
      @scoreboard.add_scores(winner: teams[0], loser: teams[1])
    elsif scores[0] < scores[1]
      @scoreboard.add_scores(winner: teams[1], loser: teams[0])
    elsif scores[0] == scores[1]
      @scoreboard.add_scores(winner: teams[0], loser: teams[1], draw: true)
    end
  end
end

Calculator.new.run if __FILE__ == $PROGRAM_NAME
