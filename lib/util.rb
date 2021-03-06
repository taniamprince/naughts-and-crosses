# Displays welcome message at the start of the game
def welcome_message
	puts ""
	puts "#{colourize("NAUGHTS & CROSSES", "gray")}"
	puts "#{colourize("-----------------", "dark gray")}"
	puts "Welome to Naughts & Crosses."
	puts "#{colourize("CPU", "cpu")} player is Naughts and" \
		 " #{colourize("Human", "human")} player is Crosses."
	puts ""
end

# Displays which player goes first
def who_goes_first board
	puts "Randomly choosing who goes first..."
	if board.turn == "Human"
		puts "#{colourize("Human", "human")} goes first!"
	else
		puts "#{colourize("CPU", "cpu")} goes first!"
		puts ""
	end
end

# Gets move from the human player
def get_move_human board

	# Get move
	puts "Enter a move number #{colourize("(0 to quit)", "red")}:"
	move = gets.chomp
	exit if move == "0"

	# Validate move
	while board.validate(move.to_i - 1) do
		puts "Invalid move. Please pick an empty slot from 1 to 9" \
			 " #{colourize("(0 to quit)", "red")}:"
		move = gets.chomp
		exit if move == "0"
	end

	return move.to_i
end

# Gets move from the CPU
def get_move_cpu board
	puts "Thinking..."
	cpu = CPU.new
	cpu.minimax(board)
	return cpu.choice
end

# Displays the winner
def winner board
	# Check for a winner
	winner = board.check_winner

	if winner == "X"
		puts "#{colourize("Human", "human")} wins!"
		puts ""
		return true
	elsif winner == "O"
		puts "Sorry. The #{colourize("CPU", "cpu")} has won."
		puts ""
		return true
	else
		return false
	end
end

# Displays if there is a tie
def tie board
	if board.check_winner == "none"
		puts "Its a tie!"
		puts ""
	end
end

# Checks if the human wants to play again
def play_again
	puts "Hit any key to play again #{colourize("(0 to quit)", "red")}:"
	play = gets.chomp
	if play == "0"
		return false
	end
end