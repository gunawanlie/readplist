require 'rexml/document'

include REXML

class PlistFile
    def initialize(file_path)
        if !File.file?(file_path)
            abort("[ERROR] file path is not a file.")
        end

        @file_path = file_path
    end

    def get_values()
        file = File.new(@file_path)
        doc = Document.new(file)
        return get_xml_values(doc.root.elements['dict'], '')
    end

    private

    def get_xml_values(element, prefix_key)
        if element.name == 'dict'
            key_format = prefix_key == '' ? "{{key_name}}" : "#{prefix_key}['{{key_name}}']"
            result = Hash.new
            elements = element.elements

            for i in (1..elements.count).step(2) do
                key = elements[i]
                value = elements[i+1]
                key_name = key_format.gsub("{{key_name}}", key.text)
                r = get_xml_values(value, key_name)
                result = result.merge(r)
            end
            return result
        elsif element.name == 'array'
            key_format = "#{prefix_key}[{{key_name}}]"
            result = Hash.new
            elements = element.elements

            for i in (1..elements.count) do
                value = elements[i]
                key_name = key_format.gsub("{{key_name}}", (i-1).to_s)
                r = get_xml_values(value, key_name)
                result = result.merge(r)
            end
            return result
        elsif element.name == 'string' || element.name == 'real' || element.name == 'date' || element.name == 'data'
            return {
                prefix_key => element.text || ''
            }
        elsif element.name == 'true' || element.name == 'false'
            return {
                prefix_key => element.name
            }
        end

        return {}
    end
end
