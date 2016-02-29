class Board
	attr_reader :state, :turn
	attr_writer :turn

	# Winning positions
	WINNERS = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

	# State is row vector representing the board
	# The positions correspond as follows
	# 1|2|3
    # -+-+-
    # 4|5|6 -> [ 1 2 3 4 5 6 7 8 9 ]
    # -+-+-
    # 7|8|9
	def initialize state, turn
		@state = state
		@turn = turn
	end

	# Creates and returns a copy of the board
	def new_board
	    board = self.class.new @state.dup, @turn.dup
	    return board
  	end

	# Displays the board
	def display
	    puts ""
	    puts " #{@state[0]} | #{@state[1]} | #{@state[2]}"
	    puts " --------- "
	    puts " #{@state[3]} | #{@state[4]} | #{@state[5]}"
	    puts " --------- "
	    puts " #{@state[6]} | #{@state[7]} | #{@state[8]}"
	    puts ""
  	end

  	# Returns true if move is invalid, false otherwise
  	def validate move
		if move.between?(0, 8)
			if @state[move] == "#{colourize("X", "human")}" || @state[move] == "#{colourize("O", "cpu")}"
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
				if @state[i - 1] == "#{colourize("X", "human")}"
          			xCount = xCount + 1
        		elsif @state[i - 1] == "#{colourize("O", "cpu")}"
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