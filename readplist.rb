require 'pathname'

require_relative 'plist_reader/plist_reader.rb'
require_relative 'utilities/arguments_parser.rb'

options = ArgumentsParser.parse(ARGV)

path = options['path'] || '.'
filename = options['filename'] || ''
regex = options['regex'] || ''
dir = options['dir'] || '.'
output = options['output'] || 'plist.csv'

if filename.empty? && regex.empty?
    ArgumentsParser.parse('-h')
else
    plist_reader = PlistReader.new()
    plist_reader.generate_report(path, filename, regex, dir, output)
end
