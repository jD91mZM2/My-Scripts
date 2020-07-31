use strict;
use warnings;

my @prefixes = (
  "",
  "hena",
  "di",
  "tri",
  "tetra",
  "penta",
  "hexa",
  "hepta",
  "octa",
  "ennea",
 );

if (@ARGV < 1) {
  print "Usage: polygon.pl <number of sides>\n";
  exit;
}

my $number = $ARGV[0];

if ($number == 0) {
  print "Don't be silly, there's no 0-sided polygon...\n";
  exit;
}

if ($number >= 30) {
  print $prefixes[$number / 10], "conta";
  print "kai" if $number % 10 > 0;
} elsif ($number >= 20) {
  print "icos";
  if ($number % 10 == 0) {
    print "a";
  } else {
    print "i";
  }
}

$number %= 10;

print $prefixes[$number] if ($number > 0);

print "gon\n";
