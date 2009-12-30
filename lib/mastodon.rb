require 'set'

require 'mastodon/todo'

class Mastodon
    # A context is: An at-sign (@) followed by one or more non-whitespace characters.
    Context_Regex  = /(?<!\+)\B@(\S+)/
    # A project is: An plus sign (+) followed by one or more non-whitespace characters.
    Project_Regex  = /(?<!@)\B\+(\S+)/
    # A priority is: A capital letter (A-Z) surrounded by parentheses, at the beginning of the line.
    Priority_Regex = /^\(([A-Z])\)/

    attr_reader :contexts, :projects, :todos

    # +todo+: An array of strings (each being an individual todo item)
    def initialize(todos)
        parse! todos.map{|line| line.strip}
    end

    def parse!(todos)
        @contexts = Set.new
        @projects = Set.new
        @todos = []

        todos.each do |todo|
            # Looping through the string, find the metadata (context, project,
            # priority). Store it in a temporary variable, then clear it from
            # the original string. Strip all remaining whitespace at the end.

            current_contexts = []
            current_projects = []
            current_priority = nil

            if current_contexts = pull_regex(todo, Context_Regex)
                @contexts.merge(current_contexts)
            end

            if current_projects = pull_regex(todo, Project_Regex)
                @projects.merge(current_projects)
            end

            current_priority = pull_regex(todo, Priority_Regex)

            todo.strip!
            @todos << Mastodon::Todo.new(todo, current_contexts, current_projects, current_priority.first)
        end

        @contexts = @contexts.to_a
        @projects = @projects.to_a
    end

    # How many todos there are.
    def size
        @todos.size
    end

    # Get an individual todo. The id and line number are the same. 0 index, not
    # 1, as files are numbered. So line 3 is id 2. XXX: Change?
    def [](id)
        @todos[id]
    end

    # Find all todos that have the context @+context+
    def find_context(context)
        @todos.select { |todo| todo.contexts.include? context }
    end

    # Find all todos that have the project ++project+
    def find_project(project)
        @todos.select { |todo| todo.projects.include? project }
    end

    # Given 'string', find all matches of regular expression (removed from
    # +string+) and return them as an array of strings.
    def pull_regex(string, regexp)
        found_values = []

        until ((value = string[regexp]).nil?)
            index = string.index(value)
            string[ index .. (index + value.length) ] = ""
            found_values << value.match(regexp)[1]
        end

        return found_values
    end
    private :pull_regex
end
