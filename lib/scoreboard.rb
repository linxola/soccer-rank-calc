# frozen_string_literal: true

# Class that represents a soccer league's ranking table
class Scoreboard
  def initialize
    @board = {}
  end

  attr_reader :board

  def add_scores(winner:, loser:, draw: false)
    winner_points, loser_points = draw ? [1, 1] : [3, 0]
    new_scores = { winner => winner_points, loser => loser_points }

    board.merge!(new_scores) { |_, old, new| old + new }
  end
end
