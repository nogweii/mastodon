class String
    # Given 'string', find all matches of regular expression (removed from
    # +string+) and return them as an array of strings.
    def pull_regex(regexp)
        found_values = []

        until ((value = self[regexp]).nil?)
            vindex = index(value)
            self[ vindex .. (vindex + value.length) ] = ""
            found_values << value.match(regexp)[1]
        end

        return found_values
    end
end
