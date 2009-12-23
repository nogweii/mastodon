require 'mastodon/todo'
require 'mastodon/version'

class Mastodon
    # A context is: An at-sign (@) followed by one or more non-whitespace characters.
    Context_Regex  = /@([^\s]+)/
    # A project is: An plus sign (+) followed by one or more non-whitespace characters.
    Project_Regex  = /\+([^\s]+)/
    # A priority is: A capital letter (A-Z) surrounded by parentheses, at the beginning of the line.
    Priority_Regex = /^\(([A-Z])\)\s/

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
            # Looping through the string, find the next context/project. Remove
            # it from the string. Add it to the correct set. Then clear any
            # remaining whitespace.

            current_contexts = []
            current_projects = []

            until ((context = todo[Context_Regex]).nil?)
                index = todo.index(context)
                todo[index..(index+context.length)] = ""
                current_contexts << context.match(Context_Regex)[1]
                contexts << context.match(Context_Regex)[1]
            end

            until ((project = todo[Project_Regex]).nil?)
                index = todo.index(project)
                todo[index..(index+project.length)] = ""
                current_projects << project.match(Project_Regex)[1]
                projects << project.match(Project_Regex)[1]
            end

            priority = todo[Priority_Regex]
            unless priority.nil?
                todo[0..4] = "" # We know 0..4 as the priority begins the line (0) is always 1 character long (1) surrounded by parentheses (+2) and is followed by a space (+1).
                priority = priority.match(Priority_Regex)[1]
            end

            todo.strip!
            @todos << Mastodon::Todo.new(todo, current_contexts, current_projects, priority)
        end
    end

    # How many todos there are.
    def size
        @lines.size
    end

    # Get an individual todo. The id and line number are the same.
    def [](id)
        @todos[id]
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
