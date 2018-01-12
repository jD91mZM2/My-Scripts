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

words = File.read("/usr/share/dict/words").lines.map{|word| word.strip.upcase}

range = 'Z'.ord - 'A'.ord
for i in (-range/2..range/2-1) do
    next if i == 0
    shifted = shift input, i
    if words.include? shifted
        puts shifted + " (Shift " + i.to_s + ")"
    end
end
