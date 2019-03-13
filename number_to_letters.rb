require 'date'
LETTERS = { '2' => %w[a b c], '3' => %w[d e f], '4' => %w[g h i], '5' => %w[j k l], '6' => %w[m n o], '7' => %w[p q r s], '8' => %w[t u v], '9' => %w[w x y z]}.freeze
DICTIONARY = {}
File.foreach('dictionary.txt') { |word| DICTIONARY[word.freeze.length].nil? ? DICTIONARY[word.freeze.length] = [word.freeze.chop.to_s.downcase] : DICTIONARY[word.freeze.length] << word.freeze.chop.to_s.downcase }
class NumberToLetters
	def letter_combinations(digits)
		time_start = Time.now
		#returns if number is not valid

		keys = digits.chars.map { |digit| LETTERS[digit] }
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
		final_words = []
		results.each do |_key, combinataions|
			next if combinataions.first.nil? || combinataions.last.nil?

			combinataions.first.product(combinataions.last).each do |combo_words|
				final_words << combo_words
			end
		end
		#for all numbers
		final_words << (keys.shift.product(*keys).map(&:join) & DICTIONARY[11]).join(', ') #match all the character
		time_end = Time.now
		puts "Time #{time_end.to_f - time_start.to_f}"
		final_words
	end
	puts "Enter the 10 digit number"
	digit_number = gets.chomp
	flag = false
	begin
		if (digit_number.to_i.digits.count == 10) && !digit_number.to_i.digits.include?(1) && !digit_number.to_i.digits.include?(0) && ((digit_number =~ /\d{10}$/) == 0)
			puts "Valid input"
			final_words = NumberToLetters.new.letter_combinations(digit_number)
			puts final_words
		else
			puts "Enter digits with digit count 10 and 0/1 should not to be included"
		end
	rescue Exception => e
		puts 'Please enter the valid input'
	end

end