class Test

def stuff
	x = 5;
	puts x
end

def stuff2
	x = 8;
	puts x
end

end

puts "beforestuff"
Test.new.stuff
Test.new.stuff2
puts "afterstuff"
