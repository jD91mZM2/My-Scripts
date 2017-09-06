trap("INT") do
    exit
end

print "Number: "
$result = gets.strip

def test(text, num)
    text += num.to_s
    if num >= 9
        result = `simple-math "#{text}" 2> /dev/null`.strip
        if result == $result || result.start_with?($result + ".")
            puts text + " = " + result
        end
        return
    end

    test(text + "+", num + 1)
    test(text + "-", num + 1)
    test(text + "*", num + 1)
    test(text + "/", num + 1)
end

test("", 1)
