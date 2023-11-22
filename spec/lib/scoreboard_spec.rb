# frozen_string_literal: true

require_relative '../../lib/scoreboard'

RSpec.describe Scoreboard do
  subject(:scoreboard) { described_class.new }

  describe '#add_scores' do
    context 'when passed teams are not in the scoreboard yet' do
      context 'when there are a winner and a loser' do
        it 'adds winner with 3 points and loser with 0' do
          scoreboard.add_scores(winner: 'Lions', loser: 'Snakes')
          expect(scoreboard.board).to eq({ 'Lions' => 3, 'Snakes' => 0 })
        end
      end

      context 'when there is a draw' do
        it 'adds both the winner and loser with 0 points' do
          scoreboard.add_scores(winner: 'Lions', loser: 'Snakes', draw: true)
          expect(scoreboard.board).to eq({ 'Lions' => 1, 'Snakes' => 1 })
        end
      end
    end

    context 'when some of the passed teams already are in the scoreboard' do
      before do
        scoreboard.add_scores(winner: 'Lions', loser: 'FC Awesome', draw: true)
      end

      context 'when there are a winner and a loser' do
        it 'adds/updates winner team with 3 points and the loser one with 0' do
          scoreboard.add_scores(winner: 'Lions', loser: 'Snakes')
          expect(scoreboard.board)
            .to eq({ 'Lions' => 4, 'FC Awesome' => 1, 'Snakes' => 0 })
        end
      end

      context 'when there is a draw' do
        it 'adds/updates both the winner and loser teams with 0 points' do
          scoreboard.add_scores(winner: 'Lions', loser: 'Snakes', draw: true)
          expect(scoreboard.board)
            .to eq({ 'Lions' => 2, 'FC Awesome' => 1, 'Snakes' => 1 })
        end
      end
    end
  end

  describe '#print_ranking' do
    before do
      scoreboard.add_scores(winner: 'Lions', loser: 'Grouches')
      scoreboard.add_scores(winner: 'Tarantulas', loser: 'Snakes')
      scoreboard.add_scores(winner: 'Lions', loser: 'FC Awesome', draw: true)
      scoreboard.add_scores(winner: 'Tarantulas', loser: 'FC Awesome')
      scoreboard.add_scores(winner: 'Lions', loser: 'Snakes', draw: true)
    end

    it 'prints the ranking table of previously added game results' do
      expect { scoreboard.print_ranking }.to output(
        "1. Tarantulas, 6 pts\n" \
        "2. Lions, 5 pts\n" \
        "3. FC Awesome, 1 pt\n" \
        "3. Snakes, 1 pt\n" \
        "4. Grouches, 0 pts\n"
      ).to_stdout
    end
  end
end
