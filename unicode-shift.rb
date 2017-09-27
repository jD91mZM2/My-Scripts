print "Input: ";
input = gets.chomp;

puts "Useful shifts: 'Lowercase Italic' = 119789 'Lowercase Bold' = 119737"
print "Shift: "
shift = Integer(gets.chomp)

result = ""
for char in input.split("")
	if char == ' '
		result += ' '
		next
	end
	result += (char.ord + shift).chr(Encoding::UTF_8)
end
puts result
