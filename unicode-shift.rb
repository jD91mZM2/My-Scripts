print "Input: ";
input = gets.chomp;

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
