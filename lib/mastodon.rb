require 'mastodon/version'

class Mastodon

    # +todo+: An array of strings (each being an individual todo item)
    def initialize(todo)
        @lines = todo.map{|line| line.strip}
    end

# contexts {{{
    Context_Regex = /@([A-Za-z]+)/
    # The contexts in the todo file
    def contexts
        @contexts ||= contexts!
    end

    # Loop through each line and find the project context with it
    def contexts!
        contexts = []
        @lines.map do |todo|
            matchdata = todo.match(Context_Regex)
            contexts << matchdata[1] if matchdata
        end
        contexts
    end
# }}}

# projects {{{
    Project_Regex = /\+([A-Za-z]+)/ # /\+(".*?")/
    # The projects in the todo file
    def projects
        @projects ||= projects!
    end

    # Loop through each line and find the project associated with it
    def projects!
        projects = []
        @lines.map do |todo|
            matchdata = todo.match(Project_Regex)
            projects << matchdata[1] if matchdata
        end
        projects
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

    # Find all todo's that have the context @+context+
    def find_context(context)
        @lines.grep(/@#{context}/)
    end

    # Find all todo's that have the project @+project+
    def find_project(project)
        @lines.grep(/\+#{project}/)
    end
end
