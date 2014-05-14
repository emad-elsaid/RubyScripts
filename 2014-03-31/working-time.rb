#!/usr/bin/env ruby
# Author : Emad Elsaid (https://github.com/blazeeboy)
FILENAME = 'db.txt'
OPEN, CLOSE = 1 , 0

file = File.open(FILENAME, 'a')
file.write "#{OPEN} : #{Time.new}\n"
file.flush

begin
	loop { sleep 60 } # sleep for an hour in an endless loop

rescue SystemExit, Interrupt # on exit
	file.write "#{CLOSE} : #{Time.new}\n"
	file.close
end