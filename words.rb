# Solution to the Words Challenge - Spencer Kelley
require "set"

# Internal: Generate all 4 letter (A-z) sequences in the given word.
#
# word - A string to generate the sequences for.
#
# Examples
#
#   word_seqs("arrow")
#   # => <Set: {"arro", "rrow"}>
#
# Returns a Set of the sequences.
def word_seqs(word)
	seqs = Set.new
	(0..word.length-4).each do |i|
		subword = word[i,4]
		seqs.add(subword) if subword.match(/[[:alpha:]]{4}/)
	end
	seqs
end

uniques = Hash.new
found = Set.new
File.open("dictionary.txt").each_line do |word|
	word_seqs(word).each do |seq|
		if found.add?(seq)
			uniques[seq] = word
		else
			uniques.delete(seq)
		end
	end
end
File.open("sequences.txt","w+") do |seqfile|
	File.open("words.txt","w+") do |wordfile|
		uniques.each_pair do |seq, word|
			seqfile.puts(seq)
			wordfile.puts(word)
		end
	end
end
