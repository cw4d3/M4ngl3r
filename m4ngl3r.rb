#!/usr/bin/env ruby

## M4ngl3r ##
#
# String is passed as argument, program finds all combinations of upper/lower-case, and "leet" transforms.

@input = ARGV[0]

@list = []

@l33t_list = {
    "a"     => ["4", "@"],
    "b"     => ["8"],
    "c"     => ["("],
    "e"     => ["3"],
    "f"     => ["ph"],
    "i"     => ["!", "1", "l"],
    "o"     => ["0"],
    "s"     => ["5", "$"],
    "t"     => ["7", "+"],
    "z"     => ["2"]
}

def case_permutations(str) # Credit: http://stackoverflow.com/questions/1390147/capitalization-permutations
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
    @list = perms
    @list.each {|item| l33t_permutations(item)}
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

case_permutations(@input)

@list.each do |item|
    l33t_permutations(item)
end

puts @list.uniq
