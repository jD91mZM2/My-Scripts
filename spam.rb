sleep(5)

exited = false
trap("INT") do
	exited = true
end

while true do
	if exited then
		break
	end
	dic = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	text = ""
	for i in 1..15
		text += dic[rand(dic.length)]
	end
	system("xdotool type " + text)
	system("xdotool key Return")

	sleep(1)
end
