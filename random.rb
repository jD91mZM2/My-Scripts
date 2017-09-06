print "Length: ";
len = gets.chomp;

begin
	ilen = Integer(len)
rescue ArgumentError
	puts "Not a number";
	exit;
end

dic = "abcdefghiklmnopqrstuvwxyzABCDEFGHIKLMNOPQRSTUVWXYZ0123456789";
result = "";
for i in 1..ilen
	result += dic[rand(dic.length)];
end
puts result;
