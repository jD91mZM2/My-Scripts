def clear
    print "\x1b[2J\x1b[H"
end
def goodbye
    print "\x1b[?25h\x1b[?1049l"
end

trap("INT") do
    goodbye
    exit
end

DELAY = 0.1;

print "\x1b[?25l\x1b[?1049h\x1b[H"

puts "Input:"
input = $stdin.read.strip

blink = 0

clear

for char, i in input.split("").each_with_index
    print char

    if blink < 2
        blink += 1
        sleep DELAY
    else
        blink = 0

        print "_"
        sleep DELAY
        clear
        print input[0..i]
    end
end
goodbye
