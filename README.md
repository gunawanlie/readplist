# readplist
Ruby script to aggregate plist files values into csv report.

# usage
If you localize your .plist file, Xcode will put the files under separate .lproj folders with the same filename.
```
# search all files with name Sample.plist
ruby readplist.rb --filename=Sample.plist
```

If you make a .plist files configuration manually with different name, you can use regex to search the name.
```
# search all files with "Info" + zero-to-many of any-character + "plist"
ruby readplist.rb --regex=Info.*plist
```

# available options
You can find more available options from the help menu.
```
ruby readplist.rb -h
```
```
usage: readplist.rb [options]
    -p, --path=PATH                  root folder path of the search, default to current directory
    -f, --filename=FILENAME          search with exact filename
    -r, --regex=REGEX                search with regular expression of file's path and name
    -d, --dir=DIR                    output directory
    -o, --output=OUTPUT              output file name
    -h, --help                       prints available options
```

# sample
