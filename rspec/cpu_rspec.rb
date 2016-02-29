require '../lib/board'
require '../lib/cpu'

# Board object for testing
state = [1, 2, 3, 4, 5, 6, 7, 8, 9]
turn = "CPU"
board = Board.new state, turn

RSpec.describe CPU, "#initialize" do
	context "with no arguments" do
		it "creates a cpu object with empty choice attribute" do
			cpu = CPU.new
			expect(cpu.choice).to eq []
		end
	end
end

# CPU object for testing
cpu = CPU.new

RSpec.describe CPU, "#get_moves" do
	context "with an empty board as argument" do
		it "returns an array of possible moves on the board" do
			expect(cpu.get_moves(board)).to eq state
		end
	end
	context "with a non empty board as argument" do
		it "returns an array of possible moves on the board" do
			board.state = [1, 2, 3, "X", 5, 6, 7, 8, "O"]
			expect(cpu.get_moves(board)).to eq [1, 2, 3, 5, 6, 7, 8]
		end
	end
end

RSpec.describe CPU, "#score" do
	context "with a 5 point scoring board as argument" do
		it "returns the final score of the board" do
			board.state = ["O", "O", "O", "X", 5, 6, 7, 8, "X"]
			expect(cpu.score(board)).to eq 5
		end
	end
	context "with a 1 point scoring board as argument" do
		it "returns the final score of the board" do
			board.state = ["O", "O", "O", "X", 5, "X", 7, "X", "X"]
			expect(cpu.score(board)).to eq 1
		end
	end
	context "with a -1 point scoring board as argument" do
		it "returns the final score of the board" do
			board.state = ["O", "O", "X", "X", 5, "O", "X", "X", "X"]
			expect(cpu.score(board)).to eq -1
		end
	end
	context "with a -5 point scoring board as argument" do
		it "returns the final score of the board" do
			board.state = [1, 2, 3, "X", 5, "O", "X", "X", "X"]
			expect(cpu.score(board)).to eq -5
		end
	end
end

# Winning positions
# [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]
RSpec.describe CPU, "#minimax" do
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = ["X", 2, "X", 4 , 5, 6, 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 2
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, 3, "X", "X", 6, 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 6
		end
	end
end