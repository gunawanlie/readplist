require 'optparse'

class ArgumentsParser
    def self.parse(options_raw)
        options = Hash.new

        option_parser = OptionParser.new do |opts|
            opts.banner = "usage: readplist.rb [options]"

            opts.on("-pPATH", "--path=PATH", "root folder path of the search, default to current directory") do |path|
                options['path'] = path
            end

            opts.on("-fFILENAME", "--filename=FILENAME", "search with exact filename") do |filename|
                options['filename'] = filename
            end

            opts.on("-rREGEX", "--regex=REGEX", "search with regular expression of file's path and name") do |regex|
                options['regex'] = regex
            end

            opts.on("-dDIR", "--dir=DIR", "output directory") do |dir|
                options['dir'] = dir
            end

            opts.on("-oOUTPUT", "--output=OUTPUT", "output file name") do |output|
                options['output'] = output
            end

            opts.on("-h", "--help", "prints available options") do
                puts opts
                exit
            end
        end

        begin
            option_parser.parse(options_raw)
        rescue StandardError => e
            option_parser.parse('-h')
            exit
        end

        return options
    end
end
