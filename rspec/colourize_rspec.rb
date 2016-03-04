require '../lib/colourize'

RSpec.describe "#colourize" do
	context "with cpu player as the argument" do
		it "returns text with cpu coloured" do
			expect(colourize("CPU", "cpu")).to eq "\e[0;1;32mCPU\e[0m"
		end
	end
end

RSpec.describe "#colourize" do
	context "with human player as the argument" do
		it "returns text with human coloured" do
			expect(colourize("Human", "human")).to eq "\e[0;1;34mHuman\e[0m"
		end
	end
end

RSpec.describe "#colourize" do
	context "with red as the colour argument" do
		it "returns red text" do
			expect(colourize("test", "red")).to eq "\e[0;31mtest\e[0m"
		end
	end
end

RSpec.describe "#colourize" do
	context "with gray as the colour argument" do
		it "returns gray text" do
			expect(colourize("test", "gray")).to eq "\e[0;37mtest\e[0m"
		end
	end
end

RSpec.describe "#colourize" do
	context "with dark gray as the colour argument" do
		it "returns dark gray text" do
			expect(colourize("test", "dark gray")).to eq "\e[0;1;30mtest\e[0m"
		end
	end
end