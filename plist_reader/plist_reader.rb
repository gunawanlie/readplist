require_relative 'file_provider.rb'
require_relative 'plist_file.rb'

require_relative '../utilities/csv_factory.rb'

class PlistReader
    def generate_report(root_path, filename, regex, output_dir, output_filename)
        plist_file_paths = get_file_paths(root_path, filename, regex)

        keys = []
        values = Hash.new()

        plist_file_paths.each { |file_path|
            plist_file = PlistFile.new(file_path)
            plist_values = plist_file.get_values()
            shorter_path = get_file_shorter_path(file_path)
            values[shorter_path] = plist_values

            plist_values.each do |key, value|
                if !keys.include?(key)
                    keys.append(key)
                end
            end
        }

        output_path = output_dir + "/" + output_filename
        content = build_csv_content(keys, values)
        CSVFactory.create_csv_file(output_path, content)
    end

    private

    def get_file_paths(root_path, filename, regex)
        file_provider = FileProvider.new(root_path)
        if !filename.empty?
            file_provider.get_file_paths_with_name(filename)
        else
            file_provider.get_file_paths_with_regex(regex)
        end
    end

    def get_file_shorter_path(file_path)
        return file_path.split('/')[-2..-1].join('/')
    end

    def build_csv_content(keys, values)
        content = []
        content.append(build_csv_content_title(values))

        keys = keys.sort
        keys.each { |key|
            row = [key]
            values.each do |plist_file, plist_value|
                value = plist_value[key] || ''
                row.append(value)
            end
            content.append(row)
        }

        return content
    end

    def build_csv_content_title(values)
        title = ['']
        values.each do |key, value|
            title.append(key)
        end
        return title
    end
end
