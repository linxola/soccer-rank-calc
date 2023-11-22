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

  def print_ranking
    output = board.sort_by { |score| [-score.last, score.first] }

    put_output(output)
  end

  private

  def put_output(output)
    ranks = [0]
    output.each_with_index do |score, index|
      rank = score[1] == output[index - 1][1] ? ranks.last : ranks.last + 1
      ranks.push(rank)

      puts "#{rank}. #{score[0]}, #{score[1]} #{score[1] == 1 ? 'pt' : 'pts'}"
    end
  end
end
