require '../lib/board'
require '../lib/colourize'

RSpec.describe Board, "#initialize" do
	context "with valid state and turn arguments" do
		it "creates a board object" do
			state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
			turn = "CPU"
			board = Board.new state, turn
			expect(board.state).to eq state
			expect(board.turn).to eq turn
		end
	end
end

# Board for testing
state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
turn = "CPU"
board = Board.new state, turn

RSpec.describe Board, "#new_board" do
	context "with valid board object as argument" do
		it "copies and returns new instance of the given board object" do
			copy = board.new_board
			expect(copy).not_to eq board
			expect(copy.state).to eq board.state
			expect(copy.turn).to eq board.turn
		end
	end
end

RSpec.describe Board, "#validate" do
	context "with valid move as argument" do
		it "returns true if a move is invalid, false otherwise" do
			move = 1
			expect(board.validate(move)).to eq false
		end
	end
	context "with array out of bounds move as argument" do
		it "returns true if a move is invalid, false otherwise" do
			move = -1
			expect(board.validate(move)).to eq true
		end
	end
	context "with array out of bounds move as argument" do
		it "returns true if a move is invalid, false otherwise" do
			move = 9
			expect(board.validate(move)).to eq true
		end
	end
	context "with move that is already occupied as argument" do
		it "returns true if a move is invalid, false otherwise" do
			state = ["X", 2, 3, 4, 5, 6, 7, 8, 9]
			board_occupied = Board.new state, turn
			move = 0
			expect(board_occupied.validate(move)).to eq true
		end
	end
end

RSpec.describe Board, "#check_winner" do
	context "with state where CPU is a winner" do
		it "returns the winner if a winner is found, returns none otherwise" do
			state = ["O", "O", \
				"O", 4, 5, 6, 7, 8, 9]
			board_cpu = Board.new state, turn
			expect(board_cpu.check_winner).to eq "O"
		end
	end
	context "with state where Human is a winner" do
		it "returns the winner if a winner is found, returns none otherwise" do
			state = ["X", "X", \
				"X", 4, 5, 6, 7, 8, 9]
			board_human = Board.new state, turn
			expect(board_human.check_winner).to eq "X"
		end
	end
	context "with state where the game is a tie" do
		it "returns the winner if a winner is found, returns none otherwise" do
			state = ["O", "O", "X", "X", 5, "X", "X", "O", "O"]
			board_tie = Board.new state, turn
			expect(board_tie.check_winner).to eq "none"
		end
	end
end

RSpec.describe Board, "#game_over" do
	context "with state where the game is over" do
		it "returns true if the game is over, false otherwise" do
			state = ["O", "O", "X", "X", "O", "X", "X", "O", "O"]
			board_over = Board.new state, turn
			expect(board_over.game_over).to eq true
		end
	end
	context "with state where the game is not over" do
		it "returns true if the game is over, false otherwise" do
			expect(board.game_over).to eq false
		end
	end
end