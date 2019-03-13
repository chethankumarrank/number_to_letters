require 'date'
LETTERS = { '2' => %w[a b c], '3' => %w[d e f], '4' => %w[g h i], '5' => %w[j k l], '6' => %w[m n o], '7' => %w[p q r s], '8' => %w[t u v], '9' => %w[w x y z]}
DICTIONARY = {}
File.foreach('dictionary.txt') { |word| DICTIONARY[word.length].nil? ? DICTIONARY[word.length] = [word.chop.to_s.downcase] : DICTIONARY[word.length] << word.chop.to_s.downcase }
class NumberToLetters
	def letter_combinations(numbers)
		time_start = Time.now
		#returns if number is not valid

		keys = numbers.chars.map { |digit| LETTERS[digit] }
		results = {}
		total_number = keys.length - 1 #digit count
		#Loo though all letters and get matching records with dictionary (reference)
		(2..total_number - 2).each do |i|
			first_array = keys[0..i]
			next if first_array.length < 3

			second_array = keys[i + 1..total_number]
			next if second_array.length < 3

			first_combination = first_array.shift.product(*first_array).map(&:join) #get product array 
			#get combination
			next if first_combination.nil?

			second_combination = second_array.shift.product(*second_array).map(&:join)
			next if second_combination.nil?

			results[i] = [(first_combination & DICTIONARY[i + 2]), (second_combination & DICTIONARY[total_number - i + 1])] #gte common values from arrays
		end
		# arrange words
		final_words  = []
		results.each do |_key, combinations|
			next if combinations.first.nil? || combinations.last.nil?

			combinations.first.product(combinations.last).each do |combo_words|
				final_words << combo_words
			end
		end
		#for all numbers
		final_words << (keys.shift.product(*keys).map(&:join) & DICTIONARY[11]).join(', ') #match all the character
		time_end = Time.now
		puts "Time #{time_end.to_f - time_start.to_f}"
		final_words
		byebug
	end
	puts "Enter the 10 digit number"
	digit_number = gets.chomp
end