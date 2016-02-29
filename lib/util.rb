# Welcome message displayed at the start of the game
def welcome_message
	puts ""
	puts "#{colourize("NAUGHTS & CROSSES", "gray")}"
	puts "#{colourize("-----------------", "dark gray")}"
	puts "Welome to Naughts & Crosses."
	puts "#{colourize("CPU", "cpu")} player is Naughts and #{colourize("Human", "human")} player is Crosses."
	puts ""
end

# Randomly chooses and returns which player goes first
def who_goes_first
	puts "Randomly choosing who goes first..."
	player = ["Human", "CPU"].shuffle.sample
	if player == "Human"
		puts "#{colourize("Human", "human")} goes first!"
		return "Human"
	else
		puts "#{colourize("CPU", "cpu")} goes first!"
		return "CPU"
	end
end

# Get move from human player
def get_move board

	# Get move
	puts "Enter a move number #{colourize("(0 to quit)", "red")}:"
	move = gets.chomp.to_i
	exit if move == 0

	# Validate move
	while board.validate(move - 1) do
		puts ""
		puts "Invalid move. Please pick an empty slot from 1 to 9 #{colourize("(0 to quit)", "red")}:"
		move = gets.chomp.to_i
		exit if move == 0
	end

	return move
end

# Displays the winner
def winner board
	# Check for a winner
	winner = board.check_winner

	if winner == "X"
		puts "#{colourize("Human", "human")} wins!"
		return true
	elsif winner == "O"
		puts "Sorry. The #{colourize("CPU", "cpu")} has won."
		return true
	else
		return false
	end
end

# Displays if there is a tie
def tie board
	puts ""
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