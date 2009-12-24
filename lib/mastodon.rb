require 'set'
require 'pp'

require 'mastodon/todo'
require 'mastodon/version'

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
            current_priority, priority = nil, nil

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
                index = todo.index(priority)
                todo[index..(index+priority.length)] = ""
                current_priority = priority.match(Priority_Regex)[1]
            end

            todo.strip!
            @todos << Mastodon::Todo.new(todo, current_contexts, current_projects, current_priority)
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
