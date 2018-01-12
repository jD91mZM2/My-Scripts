def shift(text, step)
	min = "A".ord

	maxTotal = "Z".ord
	max = maxTotal - min

	result = ""
	for char in text.chars
		code = char.ord

		if code < min || code > maxTotal then
			result += char
			next
		end

		num = (code - min + step) % (max + 1)
		while(num < 0) do
			puts num
			num += max
		end

		result += (num + min).chr
	end
	result
end

print "Input: "
input = gets.chomp.upcase

for i in (-13..12) do
	puts shift(input, i) + " (Shift " + i.to_s + ")"
end
