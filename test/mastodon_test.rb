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

        asserts_topic.equals  ["proj", "proj2", "proj+phone", "proj/foo", "p_r_o_j", "p-r-o-j", "+proj", "@proj"]

        asserts_topic.kind_of? Array
    end

    context "Contexts" do
        setup do
            topic.contexts
        end

        asserts_topic.equals ["con", "con2", "con@phone", "con/foo", "c_o_n", "c-o-n", "@con", "+con"]

        asserts_topic.kind_of? Array
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
#asserts(:size).equals @todos.size

        asserts "all todos are of type Mastodon::Todo" do
            !(topic.todos.map do |todo|
                todo.is_a? Mastodon::Todo
            end.index(false))
        end

        context "Lossless parsing: 1st Todo: Normal example" do
            setup do
                @todo = @todos[0].strip
                topic[0]
            end

            should "be the same characters" do
                topic.to_s.chars.to_a == @todo.chars.to_a
            end
            should "be the same length" do
                topic.to_s.length == @todo.length
            end
        end

        context "Lossless parsing: 8th Todo: Normal example, with priority" do
            setup do
                @todo = @todos[7].strip
                topic[7]
            end

            should "be the same characters" do
                topic.to_s.chars.to_a == @todo.chars.to_a
            end
            should "be the same length" do
                topic.to_s.length == @todo.length
            end
        end

        context "Lossless parsing: 17th Todo: Example without any metadata" do
            setup do
                @todo = @todos[16].strip
                topic[16]
            end

            should "be the same characters" do
                topic.to_s.chars.to_a == @todo.chars.to_a
            end
            should "be the same length" do
                topic.to_s.length == @todo.length
            end
        end
    end

    asserts "13th todo should have the context 'con'" do
        topic[13].contexts = ["con"]
    end
    asserts "14th todo should have the project 'proj'" do
        topic[14].projects = ["proj"]
    end

    context "Priority" do
        asserts "3rd todo should have no priority" do
            topic[3].priority.nil?
        end
        asserts "4th todo should have no priority" do
            topic[4].priority.nil?
        end
        asserts "5th todo should have priority A" do
            topic[5].priority = "A"
        end
        asserts "6th todo should have priority Z" do
            topic[6].priority = "Z"
        end
        asserts "7th todo should have priority Q" do
            topic[7].priority = "Q"
        end
        asserts "8th todo should have no priority" do
            topic[8].priority.nil?
        end
    end
end
