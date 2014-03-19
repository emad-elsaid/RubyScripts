#!/usr/bin/env ruby
# generate a single sentence from a canonical form
# canonical sentence is a multi sentences combined in one
# form, generator will generate a sentence from it randomly
# based on the form, for example:
# "Hello [Emad|Elsaid]" , may generate "Hello Emad" or
# "Hello Elsaid" the result is random.
# also you could nest [] inside each other to gain a multi level
# canonical sentence example:
# "[[Hi|Hello] [Emad|elsaid] | good [morning|night] sir]"
def generate(result)
	while result.include? '[' 
		s_start = result.index '['
		s_end = s_start+1
		while s_end<result.length and result[s_end]!=']'
			s_start = s_end if result[s_end] == '['
			s_end += 1
		end
		sentence = result[(s_start+1)...s_end]
		sentence = sentence.split '|'
		result = result[0...s_start] + sentence.sample + result[s_end+1...result.length]
	end
	result
end

10.times do
	puts generate '[Hello|Hi] my [friend|dear], how [are you [today|these days]|is your brother]?'
end

# Hello my friend, how is your brother?
# Hi my dear, how is your brother?
# Hello my dear, how is your brother?
# Hello my dear, how is your brother?
# Hi my friend, how is your brother?
# Hi my friend, how is your brother?
# Hello my friend, how are you these days?
# Hello my friend, how is your brother?
# Hello my friend, how are you these days?
# Hi my friend, how is your brother?