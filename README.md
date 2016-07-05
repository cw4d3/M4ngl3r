# M4ngl3r

## Overview
M4ngl3r will output all uppercase, lowercase, and leet alphabetic combinations based on a given string (supplied either by a wordlist of one string per line, or a single string using the -i option). This is a very simple, boiled down (less exhaustive) version of RSMangle (or other mangling functionality, like what's found in JtR). It's purpose is to quickly generate targeted wordlists to be used for testing purposes. No external libraries are required, and is easily extended. Disclaimer: this was written quickly for fun and only quick testing was performed--"use at your own risk". Also, depending on the options used and size of wordlist, the results can be extremely enormous. It's suggested to not use a large wordlist, and choose prefixes/suffixes wisely.

Future plans:

- [x] Add command line options
- [x] Provide support to read in strings from a file
- [x] Provide support for adding custom prefixes or suffixes
- [ ] Add more conditional checks and useful error messages
- [ ] Refactor for more efficient processing (when l33tifying)
- [ ] Add tests

### Options
```
Usage: ruby m4ngl3r.rb <-f /path/to/wordlist | -i 'foobar'> <OPTIONS>
    -f, --file=FILE                  Specify the path to your wordlist to mangle.
    -i, --input=INPUT                Specify a single string as input to mangle.
    -c, --case                       Choose this option to get all case permutations.
    -l, --leet                       Choose this option to l33tify the input.
    -a, --all                        Choose this option to get all permutations (case + leet).
    -p, --prefix=PREFIX              Add a prefix to each item. Separate with commas to make a list (-p '1,1!,123!') Note: use single quotes
    -s, --suffix=SUFFIX              Add a suffix to each item. Separate with commas to make a list (-s '1,1!,123!') Note: use single quotes
    -h, --help                       Display this screen
```

### Examples
Append STDOUT to file:
```
ruby m4ngl3r.rb -f wordlist.txt -a -s '1,1!,!@#' >> output.txt
```
Or not:
```
ruby m4ngl3r.rb --input pew --all
#=>
  PEW
  pEW
  PeW
  peW
  PEw
  pEw
  Pew
  pew
  P3W
  p3W
  P3w
  p3w
```

## License
See LICENSE
