$stderr.print "Input: "
input = gets

for c in input.bytes
    out = ""

    while c != 0
        if c & 1 == 0
            out += "0"
        else
            out += "1"
        end
        c >>= 1
    end

    while out.length < 8
        out += "0"
    end

    print out.reverse
    print " "
end

puts
