require './lib/connectfour.rb'

describe Grid do
  describe "#create_grid" do
    it "creates a 7x7 matrix" do
      grid = Grid.new
      expect(grid.create_grid).to eq(Array.new(7, Array.new(7)))
    end
  end
end

describe Gameplay do
  describe "#play_piece" do
    it "assigns a piece to the appropriate location in the grid" do
      game = Gameplay.new
      game.play_piece(2)
      expect(game.play_piece(2)).to eq(
        [ [nil, nil, nil, nil, nil, nil, nil], 
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, nil, nil, nil, nil, nil],
          [nil, nil, 'O', nil, nil, nil, nil],
          [nil, nil, 'X', nil, nil, nil, nil] ])
    end
  end

  describe "#take_turns" do
    it "switches the player each turn" do
      game = Gameplay.new
      queue = []
      3.times do
        queue.push(game.take_turns)
        game.play_piece(rand(6))
      end
      expect(queue).to eq(['X', 'O', 'X'])
    end
  end

  describe "#win_conditions" do
    it "continues the game if four across is not found" do
      game = Gameplay.new
      grid =  [ [nil, nil, nil, nil, nil, nil, nil], 
                [nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil],
                ['X', 'X', nil, nil, nil, nil, nil],
                ['X', 'X', 'X', 'O', 'O', 'O', nil] ]
      expect(game.win_conditions(grid)).to be(false)
    end

    it "ends the game if four across is found" do
      game = Gameplay.new
      grid =  [ [nil, nil, nil, nil, nil, nil, nil], 
                [nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil],
                ['X', nil, nil, nil, nil, nil, nil],
                ['X', 'O', 'O', 'O', 'O', 'X', nil] ]
      expect(game.win_conditions(grid, 'O')).to be(true)
    end

    it "ends the game if a vertical four in a row is found" do
      game = Gameplay.new
      grid =  [ [nil, nil, nil, nil, nil, nil, nil], 
                [nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, nil, nil],
                [nil, 'O', nil, nil, nil, nil, nil],
                [nil, 'O', nil, nil, nil, nil, nil],
                ['X', 'O', nil, nil, nil, nil, nil],
                ['X', 'O', 'X', 'O', 'X', 'X', nil] ]
      expect(game.win_conditions(grid, 'O')).to be(true)
    end

    it "ends the game if a diagonal four in a row is found" do
      game = Gameplay.new
      grid =  [ [nil, nil, nil, nil, nil, nil, nil], 
                [nil, nil, nil, nil, nil, nil, nil],
                [nil, nil, nil, nil, nil, 'X', nil],
                [nil, 'O', nil, nil, 'X', nil, nil],
                [nil, 'X', 'O', 'X', nil, nil, nil],
                ['X', 'O', 'X', 'X', nil, nil, nil],
                ['O', 'O', 'X', 'O', 'X', 'X', nil] ]
      expect(game.win_conditions(grid, 'X')).to be(true)
    end

    it "creates a random game" do
      game = Gameplay.new
      expect(game.random_generator).to be(true)
    end
  end
end
