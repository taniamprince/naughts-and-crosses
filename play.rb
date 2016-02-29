require './lib/board'
require './lib/cpu'
require './lib/colourize'
require './lib/util'

# Display welcome message
welcome_message

loop do
	# Randomly determine who goes first
	turn = who_goes_first

	# Initialize the board
	board = Board.new [1, 2, 3, 4, 5, 6, 7, 8, 9], turn

	# Display the board
	board.display

	# Alternate turns until a winner is found
	(1..9).each_with_index do |i|
		if board.turn == "Human" # Human turn

			# Get move from player
			move = get_move(board)

			# Add move to the board
			board.add_move(move, "#{colourize("X", "human")}")
			
			# Update player turn
			board.turn = "CPU"

		else # CPU turn

			# If this is the first move then pick a random location
			if i == 1
				move = board.state.shuffle[0]
			else # Otherwise get the best possible move
				puts "Thinking..."
				cpu = CPU.new
				cpu.minimax(board)
				move = cpu.choice
			end

			# Display CPU choice
			puts "The #{colourize("CPU", "cpu")} has chosen position #{move}"

			# Add move to the board
			board.add_move(move, "#{colourize("O", "cpu")}")

			# Update player turn
			board.turn = "Human"
		end

		# Display new state of the board
		board.display

		# Check for a winner
		break if winner(board) == true
	end

	# Check for a tie
	tie(board)

	# Check if human wants to play again
	break if play_again == false
end