require 'teststrap'

context "Mastodon" do
    setup do
        @todos = File.readlines(File.join(File.dirname(__FILE__), "todo.txt"))
        Mastodon.new(@todos)
    end

    context "Projects" do
        setup do
            topic.projects
        end

        should "find all projects" do
            topic.to_a == ["proj", "proj2", "proj+phone", "proj/foo", "p_r_o_j", "p-r-o-j", "+proj", "@proj"]
        end

        asserts "project should be returned as a Set" do
            topic.is_a? Set
        end
    end

    context "Contexts" do
        setup do
            topic.contexts
        end

        should "find all contexts" do
            topic.to_a == ["con", "con2", "con@phone", "con/foo", "c_o_n", "c-o-n", "@con", "+con"]
        end

        asserts "context should be returned as a Set" do
            topic.is_a? Set
        end
    end

    asserts "Non-existent contexts should return an empty array" do
        topic.find_context("nosuchthing") == []
    end
    asserts "Non-existent projects should return an empty array" do
        topic.find_project("thisprojectdoesntexist") == []
    end

    context "Context #2" do
        setup do
            topic.find_context("con2")
        end
        asserts "Context size should be greater than zero" do
            topic.size > 0
        end
        asserts "First todo with the context 'con2' should be 'Multiple contexts'" do
            topic.first.text == "Multiple contexts"
        end
    end

    context "Project #2" do
        setup do
            topic.find_project("proj2")
        end
        should "greater than zero" do
            topic.size > 0
        end
        asserts "First todo with the project 'proj2' should be 'Multiple projects'" do
            topic.first.text == "Multiple projects"
        end
    end

    context "Todo" do
        context "Lossless parsing" do
            setup do
                topic[0]
            end

            should "same characters" do
                topic.to_s.chars.to_a == @todos[0].strip.chars.to_a
            end
            should "same length" do
                topic.to_s.length == @todos[0].strip.length
            end

            asserts "todos are of type Mastodon::Todo" do
                topic.is_a? Mastodon::Todo
            end
        end

        should "be the same amount of todos" do
            topic.size == @todos.size
        end
    end

    asserts "13th todo should have the context 'con'" do
        topic[13].contexts = ["con"]
    end
    asserts "14th todo should have the project 'proj'" do
        topic[14].projects = ["proj"]
    end

    context "Priority" do
        asserts "Third todo should have no priority" do
            topic[3].priority.nil?
        end
        asserts "Fourth todo should have no priority" do
            topic[4].priority.nil?
        end
        asserts "Fifth todo should have priority A" do
            topic[5].priority = "A"
        end
        asserts "Sixth todo should have priority Z" do
            topic[6].priority = "Z"
        end
        asserts "Seventh todo should have priority Q" do
            topic[7].priority = "Q"
        end
        asserts "Eighth todo should have no priority" do
            topic[8].priority.nil?
        end
    end
end
