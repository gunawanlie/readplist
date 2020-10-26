class FileProvider
    def initialize(root_path)
        if !Dir.exist?(root_path)
            abort("[ERROR] root path should be a valid directory.")
        end

        @root_path = root_path
    end

    def get_file_paths_with_name(filename)
        files = []
        Dir.glob(@root_path + "/**/*").each do |file_path|
            next if !File.file?(file_path)
            if File.basename(file_path) == filename
                files.append(file_path)
            end
        end
        return files
    end

    def get_file_paths_with_regex(regex_string)
        regex = Regexp.new(regex_string)
        files = []
        Dir.glob(@root_path + "/**/*").each do |file_path|
            next if !File.file?(file_path)
            file_path.slice! @root_path + "/"
            if file_path.match(regex)
                files.append(file_path)
            end
        end
        return files
    end
end
