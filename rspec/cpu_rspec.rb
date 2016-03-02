require '../lib/board'
require '../lib/cpu'

# CPU object for testing
cpu = CPU.new

# Board object for testing
board = Board.new [1, 2, 3, 4, 5, 6, 7, 8, 9], "CPU"

# Make all methods public for testing
CPU.send(:public, *CPU.private_instance_methods)

RSpec.describe CPU, "#get_moves" do
	context "with an empty board as argument" do
		it "returns an array of possible moves on the board" do
			expect(cpu.get_moves(board)).to eq [1, 2, 3, 4, 5, 6, 7, 8, 9]
		end
	end
	context "with a non empty board as argument" do
		it "returns an array of possible moves on the board" do
			board.state = [1, 2, 3, "X", 5, 6, 7, 8, "O"]
			expect(cpu.get_moves(board)).to eq [1, 2, 3, 5, 6, 7, 8]
		end
	end
end

RSpec.describe CPU, "#count_moves" do
	context "with a board with 3 moves as argument" do
		it "adds the given move to the board" do
			board.state = ["O", "X", "O", 4, 5, 6, 7, 8, 9]
			expect(cpu.count_moves(board)).to eq 3
		end
	end
end

RSpec.describe CPU, "#add_possible_move" do
	context "with an empty board as argument" do
		it "adds the given move to the board" do
			possible = Board.new [1, 2, 3, 4, 5, 6, 7, 8, 9], "CPU"
			cpu.add_possible_move(possible, 1)
			expect(possible.state).to eq ["O", 2, 3, 4, 5, 6, 7, 8, 9]
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
			board.state = ["X", "X", 3, 4, 5, 6, 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 3
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = ["X", 2, "X", 4 , 5, 6, 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 2
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, "X", "X", 4, 5, 6, 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 1
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, 3, "X", "X", 6, 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 6
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, 3, "X", 5, "X", 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 5
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, 3, 4, "X", "X", 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 4
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, 3, 4, 5, 6, "X", "X", 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 9
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, 3, 4, 5, 6, "X", 8, "X"]
			cpu.minimax(board)
			expect(cpu.choice).to eq 8
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, 3, 4, 5, 6, 7, "X", "X"]
			cpu.minimax(board)
			expect(cpu.choice).to eq 7
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = ["X", 2, 3, "X", 5, 6, 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 7
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = ["X", 2, 3, 4, 5, 6, "X", 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 4
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, 3, "X", 5, 6, "X", 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 1
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = ["X", 2, 3, 4, "X", 6, 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 9
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = ["X", 2, 3, 4, 5, 6, 7, 8, "X"]
			cpu.minimax(board)
			expect(cpu.choice).to eq 5
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, 3, 4, "X", 6, 7, 8, "X"]
			cpu.minimax(board)
			expect(cpu.choice).to eq 1
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, "X", 4, "X", 6, 7, 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 7
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, "X", 4, 5, 6, "X", 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 5
		end
	end
	context "with a board 1 step away from winning" do
		it "should block the winning move" do
			board.state = [1, 2, 3, 4, "X", 6, "X", 8, 9]
			cpu.minimax(board)
			expect(cpu.choice).to eq 3
		end
	end
end