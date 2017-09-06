print "Numbers (separated by space): ";
input = gets.strip;

result = "";
for i in input.split(/,? /) do
	begin
		result += Integer(i).chr;
	rescue ArgumentError
		puts "Not a number.";
		exit;
	end
end

puts result;
