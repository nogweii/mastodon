require 'set'

require 'core_ext/string/pull_regex'

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
        @contexts = Set.new
        @projects = Set.new
        @todos = []

        parse! todos.map{|line| line.strip}

        @contexts = @contexts.to_a
        @projects = @projects.to_a
    end

    def parse!(todos)
        todos.each do |todo|
            # Looping through the string, find the metadata (context, project,
            # priority). Store it in a temporary variable, then clear it from
            # the original string. Strip all remaining whitespace at the end.

            current_contexts = []
            current_projects = []
            current_priority = nil

            current_contexts = todo.pull_regex(Context_Regex)
            unless current_contexts.empty?
                @contexts.merge(current_contexts)
            end

            current_projects = todo.pull_regex(Project_Regex)
            unless current_projects.empty?
                @projects.merge(current_projects)
            end

            current_priority = todo.pull_regex(Priority_Regex)

            todo.strip!
            @todos << Mastodon::Todo.new(todo, current_contexts, current_projects, current_priority.first)
        end
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
end
