require 'test/unit'

require_relative '../plist_reader/plist_file.rb'

class TestPlistFile < Test::Unit::TestCase
    def test_one_value_plist
        plist_file = PlistFile.new(__dir__ + '/localized_plist/fr-CA.lproj/Sample.plist')
        content = plist_file.get_values()

        assert_equal(content.count, 1)
    end

    def test_plist_data
        plist_file = PlistFile.new(__dir__ + '/localized_plist/Base.lproj/Sample.plist')
        content = plist_file.get_values()

        assert_equal(content.count, 11)

        assert_equal(content["BoolKey"], 'true')
        assert_equal(content["DataKey"], '')
        assert_equal(content["DateKey"], '2020-10-25T08:27:55Z')
        assert_equal(content["NumberKey"], '123.45')
        assert_equal(content["StringKey"], 'string_value')
        assert_equal(content["ArrayKey[0]"], 'ArrayValue1')
        assert_equal(content["DictKey['MyArray'][1]['nested_key']"], 'nested_value')
    end

    def test_bigger_plist
        plist_file = PlistFile.new(__dir__ + '/plists/Info_JP.plist')
        content = plist_file.get_values()

        assert_equal(content.count, 12)
        assert_equal(content["LSRequiresIPhoneOS"], 'true')
        assert_equal(content["CFBundleVersion"], '1')
    end
end
