class Mastodon

    # +todo+: An array of strings (each being an individual todo item)
    def initialize(todo)
        @lines = todo.map{|line| line.strip}
    end

# contexts {{{
    Context_Regex = /@[A-Za-z]+/
    # The contexts in the todo file
    def contexts
        @contexts ||= contexts!
    end

    # Loop through each line and find the project context with it
    def contexts!
        @lines.map do |todo|
            todo[Context_Regex]
        end
    end
# }}}

# projects {{{
    Project_Regex = /\+[A-Za-z]+/ # /\+(".*?")/
    # The projects in the todo file
    def projects
        @projects ||= projects!
    end

    # Loop through each line and find the project associated with it
    def projects!
        @lines.map do |todo|
            todo[Project_Regex]
        end
    end
# }}}

    # How many todos there are.
    def size
        @lines.size
    end

    # Get an individual todo. The id and line number are the same.
    def [](id)
        @lines[id]
    end
end
