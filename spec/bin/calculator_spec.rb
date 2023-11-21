# frozen_string_literal: true

require_relative '../../bin/calculator'

RSpec.describe Calculator do
  subject(:calculator) do
    File.expand_path('../../bin/calculator.rb', File.dirname(__FILE__))
  end

  let(:input) { File.expand_path('../samples/input.txt', File.dirname(__FILE__)) }

  it 'calculates the ranking table for a soccer league' do
    res = `ruby #{calculator} #{input}`.chomp
    expect(res).to eq(
      "1. Tarantulas, 6 pts\n" \
      "2. Lions, 5 pts\n" \
      "3. FC Awesome, 1 pt\n" \
      "3. Snakes, 1 pt\n" \
      '5. Grouches, 0 pts'
    )
  end
end
