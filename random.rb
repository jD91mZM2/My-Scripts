len = nil
if ARGV.length < 1
    print "Length: "
    len = gets.chomp
else
    len = ARGV[0]
end

begin
    ilen = Integer(len)
rescue ArgumentError
    puts "Not a number"
    exit
end

dic = "abcdefghiklmnopqrstuvwxyzABCDEFGHIKLMNOPQRSTUVWXYZ0123456789"
result = ""
for i in 1..ilen
    result += dic[rand(dic.length)]
end
puts result
