# Colours console text output using ANSI escape sequences
def colourize text, colour = "default", bgColour = "default"
    colours = {"default" => "1;37", "exit" => "31", "cpu" => "1;32", "yellow" => "1;33",
      "human" => "1;34","gray" => "37", "dark gray" => "1;30", "red" => "31"}
    bgColours = {"default" => "0"}
    colour_code = colours[colour]
    bgColour_code = bgColours[bgColour]
    return "\033[#{bgColour_code};#{colour_code}m#{text}\033[0m"
end