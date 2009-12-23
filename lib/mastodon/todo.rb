class Mastodon
    class Todo < Struct.new(:text, :contexts, :projects, :priority)
        include Comparable

        def to_s
            pri = priority ? "(#{priority})" : ""
            "#{pri} #{text} @#{contexts.join(' @')} +#{projects.join(' +')}".strip
        end

        def inspect
            "#<Mastodon::Todo \"#{to_s}\">"
        end

        # Comparison operator: Sort todos by their priority first, then sort
        # them by the text.
        def <=>(other_todo)
            return -1 if (priority.nil? and !other_todo.priority.nil?)

            pri = (priority <=> other_todo.priority)
            if pri == 0
                return text <=> other_todo.text
            else
                return pri
            end
        end
    end
end
