$stderr.print "Binary text: "
input = gets.strip

utf8 = []

for part in input.split(' ')
    byte = 0

    for c in part.chars
        byte <<= 1
        if c == '1'
            byte += 1
        elsif c != '0'
            puts "Invalid digit: " + c
            exit 1
        end
    end

    utf8.push byte
end

print utf8.pack("C*").force_encoding("UTF-8")
