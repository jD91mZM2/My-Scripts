dic = "abcdefghiklmnopqrstuvwxyzABCDEFGHIKLMNOPQRSTUVWXYZ0123456789"
exited = false
trap("INT") do
	exited = true
end
while true do
	print dic[rand(dic.length)]
	if exited then
		break
	end
end
