#!/usr/bin/env ruby

## M4ngl3r ##
#
# String is passed as argument, program finds all combinations of upper/lower-case, and "leet" transforms.

require 'optparse'

@list = []
@l33t_list = {
    "a"     => ["4", "@"],
    "b"     => ["8"],
    "c"     => ["("],
    "e"     => ["3"],
    "f"     => ["ph"],
    "i"     => ["!", "1", "l"],
    "l"     => ["1"],
    "o"     => ["0"],
    "s"     => ["5", "$"],
    "t"     => ["7", "+"],
    "z"     => ["2"]
}

@options = {}
optparse = OptionParser.new do |opts|
	opts.banner = "Example Usage: ruby m4ngl3r.rb <-f /path/to/wordlist | -i 'foobar'> <OPTIONS>"
	@options[:banner] = opts

	@options[:file] = nil
	opts.on('-f', '--file=FILE', String, 'Specify the path to your wordlist to mangle.') do |file|
		@options[:file] = file
	end

    @options[:input] = nil
	opts.on('-i', '--input=INPUT', String, 'Specify a single string as input to mangle.') do |input|
		@options[:input] = [input]
	end

	@options[:case] = nil
	opts.on('-c', '--case', 'Choose this option to get all case permutations.') do
		@options[:case] = true
	end

	@options[:leet] = nil
	opts.on('-l', '--leet', 'Choose this option to l33tify the input.') do
		@options[:leet] = true
	end

	@options[:all] = nil
	opts.on('-a', '--all', 'Choose this option to get all permutations (case + leet).') do
		@options[:all] = true
	end

    @options[:prefix] = nil
	opts.on('-p', '--prefix=PREFIX', "Add a prefix to each item. Separate with commas to make a list (-p '1,1!,123!') Note: use single quotes") do |prefix|
		@options[:prefix] = prefix
	end

    @options[:suffix] = nil
	opts.on('-s', '--suffix=SUFFIX', "Add a suffix to each item. Separate with commas to make a list (-s '1,1!,123!') Note: use single quotes") do |suffix|
		@options[:suffix] = suffix
	end

	opts.on_tail('-h', '--help', "Display this screen\n\n") do
		puts opts
		exit
	end
end

if !ARGV[0]
	puts @options[:banner]
	exit
end

optparse.parse!

if @options[:file] == nil && @options[:input] == nil
	puts "Specify a file (-f) or a string for input (-i).\n"
	puts @options[:banner]
	exit
end

if @options[:case] == nil && @options[:leet] == nil && @options[:all] == nil
	puts "Mangle type is required. (-c, -l, or -b)\n"
	puts @options[:banner]
	exit
end

if @options[:file] != nil && @options[:input] == nil
    @input = File.readlines(@options[:file]).each {|l| l.strip!} #remove /n chars
elsif @options[:file] != nil && @options[:input] != nil
    puts "You can only choose one: file as input (-f) or string as input (-i)."
    exit
end

if @options[:input] != nil && @options[:file] == nil
    @input = @options[:input]
elsif @options[:file] != nil && @options[:input] != nil
    puts "You can only choose one: file as input (-f) or string as input (-i)."
    exit
end

def case_permutations(str)
# Credit: http://stackoverflow.com/questions/1390147/capitalization-permutations
    perms = [""]
    tail = str.downcase

    while tail.length > 0 do
        head, tail, psize = tail[0..0], tail[1..-1], perms.size
        hu = head.upcase
        for i in (0...psize)
            tp = perms[i]
            perms[i] = tp + hu
            if hu != head
                perms.push(tp + head)
            end
        end
    end
    @list += perms
end

def l33t_permutations(str)
    # check to find which characters can be substituted with leet
    # map substitutable characters to matching positions in the str array

    results = [] # list of mangled results
    @sub_positions = [] # positions in the str array that can be mangled
    original_str = str
    str = str.downcase.split("")

    #find chars eligible for substitution from hash list (["e", "s"])
    hash_sub_chars = @l33t_list.select {|k,v| str.include? k}

    #find array element positions eligible for substituion from str array ([0,2,6])
    hash_sub_chars.keys.each do |key|
        @sub_positions << str.each_index.select{|i| str[i] == key}
    end
    @sub_positions = @sub_positions.flatten!.sort if @sub_positions.count >= 1
    @repetitions = @sub_positions.count if @sub_positions.count >= 1

	@sub_positions.each do |m|
        modified_str = original_str.split("")

        # get the substitute char(s) out of the hash
        res = @l33t_list.detect {|k,v| k == str[m]}

        if res != nil && res[1].count <= 1
            modified_str[m] = res[1]
            results.push modified_str.join("") unless @list.include? modified_str.join("")
        elsif res != nil && res[1].count > 1
            res[1].each do |lchar|
                modified_str[m] = lchar
                results.push modified_str.join("") unless @list.include? modified_str.join("")
            end
        end
    end

    # recurse through the results to apply more l33tification
    @repetitions.times {
        results.each do |l|
            l33t_permutations(l)
        end
    }
    @list += results
end

def add_prefix(prefixes)
    pref_result = []
    prefixes = prefixes.split(",")
    prefixes.each do |pre|
        items = @list.map {|x| pre + x}
        pref_result.push items
    end
    @list += pref_result.flatten!
end

def add_suffix(suffixes)
    suff_result = []
    suffixes = suffixes.split(",")
    suffixes.each do |suff|
        items = @list.map {|x| x + suff}
        suff_result.push items
    end
    @list += suff_result.flatten!
end

if @options[:case]
	@input.each {|i| case_permutations(i)}
end

if @options[:leet]
	@input.each {|i| l33t_permutations(i)}
end

if @options[:all]
	@input.each {|i| case_permutations(i)}
	@list.each {|l| l33t_permutations(l)}
end

if @options[:prefix]
    add_prefix(@options[:prefix])
end

if @options[:suffix]
    add_suffix(@options[:suffix])
end

puts @list
