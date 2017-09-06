# Removed Q and XYZ
vocal = "aouei";
consonant = "bcdfghjklmnprstvw";

max_length = 10;
if ARGV.length >= 1 then
	begin
		max_length = Integer(ARGV[0]);
	rescue ArgumentError
		puts "Invalid argument: Length must be a number.";
		exit;
	end
end

result = "";
consonants = 1;
vocals = 0;
for i in 1..(rand(max_length) + 1) do
	if vocals > 1 || rand(2) == 0 && consonants <= 1 then
		result += consonant[rand(consonant.length)];
		consonants += 1;
		vocals = 0;
	else
		result += vocal[rand(vocal.length)];
		vocals += 1;
		consonants = 0;
	end
end

puts result;
