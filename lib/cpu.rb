class CPU

	attr_reader :choice

	# Public ---------------------------------------------------------

	def initialize
		@choice = []  # Move the CPU will make
	end

	# Minimax algorithm to determine the best possible move
	def minimax board

		# Return the final score if the game is over
		return score(board) if board.game_over == true

		scores = [] # Array to store possible scores
		moves = []  # Array to store possible moves

		# Recursively get possible scores
			get_moves(board).each do |move|

			# Get a new instance of the board
			possible = board.new_board

			# Add possible move to the board
			add_possible_move(possible, move)

			# Store score and move
			scores.push minimax(possible)
			moves.push move
		end

		if board.turn == "CPU" # Find and return the max score
			maxScore = scores.each_with_index.max[1]
			@choice = moves[maxScore]
			return scores[maxScore]
		else # Find and return the min score
			minScore = scores.each_with_index.min[1]
			@choice = moves[minScore]
			return scores[minScore]
		end
	end

	# Private ---------------------------------------------------------

	# Returns an array of available moves
	private def get_moves board
		moves = []
		board.state.each do |move|
			if move.to_i.between?(1, 9)
				moves.push move
			end
		end
		return moves
	end

	# Adds possible move to the board and alternates turn
	private def add_possible_move board, move
		if board.turn == "CPU"
			board.add_move(move, "O")
			board.turn = "Human"
		else
			board.add_move(move, "X")
			board.turn = "CPU"
		end
	end

	# Counts the number of moves played on the board
	private def count_moves board
		moves = 0
		board.state.each do |move|
			if !move.to_i.between?(1, 9)
				moves = moves + 1
			end
		end
		return moves
	end

	# Scores a move
	private def score board
		# Count the number of moves
		moves = count_moves(board)

		# Get winner
		winner = board.check_winner

		# Score the board
		if winner == "O" && moves <= 5
			return 5  # Give a large, positive score if it was a fast win
		elsif winner == "O" && moves > 5
			return 1  # Give a small, positive score if it was a slow win
		elsif winner == "X" && moves > 5
			return -1 # Give a small, negative score if it was a slow loss
		elsif winner == "X" && moves <= 5
			return -5 # Give a large, negative score if it was a fast loss
		else
			return 0  # Give a score of 0 if the board is a draw
		end
	end

end