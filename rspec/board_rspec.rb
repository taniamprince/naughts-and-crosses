require '../lib/board'

RSpec.describe Board, "#initialize" do
	context "with valid state and turn arguments" do
		it "creates a board object" do
			board = Board.new
			expect(board.state).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9]
			expect(board.turn == "Human" || board.turn == "CPU").to eq true
		end
	end
end

# Board for testing
board = Board.new
board.turn = "CPU"

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
			expect(board.validate(1)).to eq false
		end
	end
	context "with array out of bounds move as argument" do
		it "returns true if a move is invalid, false otherwise" do
			expect(board.validate(-1)).to eq true
		end
	end
	context "with array out of bounds move as argument" do
		it "returns true if a move is invalid, false otherwise" do
			expect(board.validate(9)).to eq true
		end
	end
	context "with move that is already occupied as argument" do
		it "returns true if a move is invalid, false otherwise" do
			board.state = ["X", 2, 3, 4, 5, 6, 7, 8, 9]
			expect(board.validate(0)).to eq true
		end
	end
end

RSpec.describe Board, "#check_winner" do
	context "with state where CPU is a winner" do
		it "returns the winner if a winner is found, returns none otherwise" do
			board.state = ["O", "O", "O", 4, 5, 6, 7, 8, 9]
			expect(board.check_winner).to eq "O"
		end
	end
	context "with state where Human is a winner" do
		it "returns the winner if a winner is found, returns none otherwise" do
			board.state = ["X", "X", "X", 4, 5, 6, 7, 8, 9]
			expect(board.check_winner).to eq "X"
		end
	end
	context "with state where the game is a tie" do
		it "returns the winner if a winner is found, returns none otherwise" do
			board.state = ["O", "O", "X", "X", 5, "X", "X", "O", "O"]
			expect(board.check_winner).to eq "none"
		end
	end
end

RSpec.describe Board, "#game_over" do
	context "with state where the game is a tie" do
		it "returns true if the game is over, false otherwise" do
			board.state = ["O", "O", "X", "X", "O", "X", "X", "O", "O"]
			expect(board.game_over).to eq true
		end
	end
	context "with state where the human has won" do
		it "returns true if the game is over, false otherwise" do
			board.state = ["X", "X", "X", "O", "O", 6, 7, 8, 9]
			expect(board.game_over).to eq true
		end
	end
	context "with state where the cpu has won" do
		it "returns true if the game is over, false otherwise" do
			board.state = ["O", "O", "O", "X", "X", 6, 7, 8, 9]
			expect(board.game_over).to eq true
		end
	end
	context "with state where the game is not over" do
		it "returns true if the game is over, false otherwise" do
			board.state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
			expect(board.game_over).to eq false
		end
	end
end