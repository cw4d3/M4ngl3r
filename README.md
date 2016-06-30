# M4ngl3r

## Overview
M4ngl3r will output all uppercase, lowercase, and "leet" alphabetic combinations based on a given string (supplied as an argument). This is a very simple, boiled down (less exhaustive) version of RSMangle (or other mangling functionality, like what's found in JtR). It's purpose is to quickly generate targeted wordlists to be used for testing purposes. No external libraries are required, and is easily extended. Disclaimer: this was written quickly for fun and only quick testing was performed--"use at your own risk".

Future plans:

- Add command line options 
- Provide support to read in strings from a file
- Provide support for adding custom prefixes or suffixes
- Provide support for adding common prefixes or suffixes
- Add tests

## Usage
```
ruby m4ngl3r.rb string >> list.txt
```

```
ruby m4ngl3r.rb pew
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