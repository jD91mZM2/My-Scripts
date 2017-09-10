require "redd"

print "Username: "
username  = gets.strip
print "Password: "
password  = gets.strip
print "Client ID: "
client_id = gets.strip
print "Secret: "
secret    = gets.strip

session = Redd.it(
    user_agent: "Redd:reddit-chain-a-roo:v0.1.0 (by /u/jD91mZM2)",
    username: username,
    password: password,
    client_id: client_id,
    secret: secret
)

print "Comment ID: "
id = gets.strip

puts

loop {
    body = session.from_ids(["t1_" + id]).to_ary[0].body
    puts body
    matches = /\(https?:\/\/(?:www.)?reddit\.com\/.*\/([a-zA-Z0-9]+)\/?(?:\?.*)?\)/.match(body)
    break if matches.nil?
    id = matches[1]
}
