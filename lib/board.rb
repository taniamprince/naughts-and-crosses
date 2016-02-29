class Board
	attr_reader :state, :turn
	attr_writer :turn

	# Winning positions
	WINNERS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

	# State is an array representing the board
	# The positions correspond as follows
	# 1 | 2 | 3
	# ---------
	# 4 | 5 | 6 -> [ 1 2 3 4 5 6 7 8 9 ]
	# ---------
	# 7 | 8 | 9
	def initialize state, turn
		@state = state
		@turn = turn
	end

	# Creates and returns a copy of the board object
	def new_board
	    board = self.class.new @state.dup, @turn.dup
	    return board
  	end

	# Displays the board
	def display
	    puts ""
	    puts " #{colour(@state[0])} | #{colour(@state[1])} | #{colour(@state[2])}"
	    puts " --------- "
	    puts " #{colour(@state[3])} | #{colour(@state[4])} | #{colour(@state[5])}"
	    puts " --------- "
	    puts " #{colour(@state[6])} | #{colour(@state[7])} | #{colour(@state[8])}"
	    puts ""
  	end

  	# Returns true if move is invalid, false otherwise
  	def validate move
		if move.between?(0, 8)
			if @state[move] == "X" || @state[move] == "O"
				return true
			else
				return false
			end
		else
			return true
		end
	end

	# Adds move to the board
	def add_move move, player
		@state[move - 1] = player
	end

	# If a winner is found the winner is returned, returns "none" oherwise
	def check_winner
		xCount = 0 # Keep track of X's on board
		oCount = 0 # Keep track of O's on board

		# Search through each winning combination and count the matches for both players
		Board::WINNERS.each do |winner|
			winner.each do |i|
				if @state[i - 1] == "X"
          			xCount = xCount + 1
        		elsif @state[i - 1] == "O"
          			oCount = oCount + 1
        		end
			end

			# If either count is 3 then we have found a winner
			if xCount == 3 || oCount == 3
				break
			else # Otherwise no winner is found so reset counts for next iteration
				xCount = 0
				oCount = 0
			end
		end

		# Return results
		if xCount == 3
			return "X"
		elsif oCount == 3
			return "O"
		else
			return "none"
		end
	end	

	# Returns true if the game is over, false otherwise
	def game_over
		over = true
		@state.each do |move|
			if move.to_i.between?(1, 9)
				over = false
				break
			end
		end
		return over
	end

end