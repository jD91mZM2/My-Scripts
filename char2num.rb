print "Please enter characters: "
chars = gets.strip

result = ""
first = true
for i in chars.split("") do
	if first
		first = false
	else
		result += ", "
	end
	result += i.ord.to_s
end

puts result
