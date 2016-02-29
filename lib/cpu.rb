class CPU
	attr_reader :choice

	def initialize
		@choice = []  # Move the CPU will make
	end

	# Returns an array of available moves
	def get_moves board
		moves = []
		board.state.each do |move|
			if move.to_i.between?(1, 9)
				moves.push move
			end
		end
		return moves
	end

	# Scores a move
	def score board
		# Give score of 0 if the board is a draw
		# Give a large, positive score if it was a fast win (if it only took 5 moves to win)
		# Give a small, positive score if it was a slow win (if it took all 9 moves to win)
		# Give a small, negative score if it was a slow loss (if it took all 9 moves to lose)
		# Give a large, negative score if it was a fast loss (if it only took 5 moves to lose)

		moves = 0 # Keeps track of the number of moves

		# Count the number of moves
		board.state.each do |move|
			if !move.to_i.between?(1, 9)
				moves = moves + 1
			end
		end

		# Get winner
		winner = board.check_winner

		# Score the state of the board
		if winner == "O" && moves <= 5
			return 5
		elsif winner == "O" && moves > 5
			return 1
		elsif winner == "X" && moves <= 5
			return -1
		elsif winner == "X" && moves > 5
			return -5
		else
			return 0
		end

	end

	# Minimax algorithm to determine best possible move
	def minimax board
		# Return the score if the game is over
		if board.game_over == true
			if score(board) == 5
				puts score(board)
			end
		end
		return score(board) if board.game_over == true

		scores = [] # Array to store possible scores
		moves = []  # Array to store possible moves

		moves.push(99)
		if board.turn == "CPU"
			scores.push(-10)
		else
			scores.push(10)
		end

	    # Recursively populate possible scores
	    get_moves(board).each do |move|
	    	possible = board.new_board
	    	if possible.turn == "CPU"
	    		possible.add_move(move, "#{colourize("O", "cpu")}")
	    		possible.turn = "Human"
	    	else
	    		possible.add_move(move, "#{colourize("X", "human")}")
	    		possible.turn = "CPU"
	    	end
	    	scores.push minimax(possible)
	    	moves.push move
    	end

    	if board.turn == "CPU"
    		maxScore = scores.each_with_index.max[1]
    		@choice = moves[maxScore]
    		return scores[maxScore]
    	else
    		minScore = scores.each_with_index.min[1]
    		@choice = moves[minScore]
        	return scores[minScore]
        end
	end

end