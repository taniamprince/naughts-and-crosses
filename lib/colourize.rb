# Colours console text output using ANSI escape sequences
def colourize text, colour = "default", bgColour = "default"
    colours = {"default" => "1;37", "human" => "1;34", "cpu" => "1;32",
      "gray" => "37", "dark gray" => "1;30", "red" => "31"}
    bgColours = {"default" => "0"}
    colour_code = colours[colour]
    bgColour_code = bgColours[bgColour]
    return "\033[#{bgColour_code};#{colour_code}m#{text}\033[0m"
end

# Returns a move with colour
def colour move
	if move == "X"
		return "#{colourize("X", "human")}"
	elsif move == "O"
		return "#{colourize("O", "cpu")}"
	else
		return move
	end
end