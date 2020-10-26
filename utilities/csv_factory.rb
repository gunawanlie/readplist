require 'csv'
require 'fileutils'

class CSVFactory
    def self.create_csv_file(file_path, content)
        CSVFactory.create_directory(file_path)
        CSV.open(file_path, "wb") do |csv|
            content.each { |row_data|
                csv << row_data
            }
        end
    end

    private

    def self.create_directory(file_path)
        directory_path = File.dirname(file_path)
        FileUtils.mkdir_p(directory_path)
    end
end
