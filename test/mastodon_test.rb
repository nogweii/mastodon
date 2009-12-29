require 'teststrap'

context "Mastodon" do
    setup do
        @todos = File.readlines(File.join(File.dirname(__FILE__), "todo.txt"))
        Mastodon.new(@todos)
    end

    should "find all projects" do
        topic.projects.to_a == ["proj", "proj2", "proj+phone", "proj/foo", "p_r_o_j", "p-r-o-j", "+proj", "@proj"]
    end

    should "find all contexts" do
        topic.contexts.to_a == ["con", "con2", "con@phone", "con/foo", "c_o_n", "c-o-n", "@con", "+con"]
    end

    asserts "Non-existent contexts should return an empty array" do
        topic.find_context("nosuchthing") == []
    end
    asserts "Non-existent projects should return an empty array" do
        topic.find_project("thisprojectdoesntexist") == []
    end

    asserts "Context size should be greater than zero" do
        topic.find_context("con2").size  > 0
    end
    asserts "First todo with the context 'con2' should be 'Multiple contexts'" do
        topic.find_context("con2").first.text == "Multiple contexts"
    end
    asserts "Project size should greater than zero" do
        topic.find_project("proj2").size > 0
    end
    asserts "First todo with the project 'proj2' should be 'Multiple projects'" do
        topic.find_project("proj2").first.text == "Multiple projects"
    end

    asserts "same characters and the same length" do
        (topic[0].to_s.chars.to_a == @todos[0].strip.chars.to_a) and (topic[0].to_s.length == @todos[0].strip.length)
    end
    asserts "There should be the same amount of todos" do
        topic.size == @todos.size
    end
    asserts "project should be returned as a Set" do
        topic.projects.is_a? Set
    end
    asserts "context should be returned as a Set" do
        topic.contexts.is_a? Set
    end
    asserts "Confirm that the retrieved todos are of type Mastodon::Todo" do
        topic[0].is_a? Mastodon::Todo
    end
    asserts "13th todo should have the context 'con'" do
        topic[13].contexts = ["con"]
    end
    asserts "14th todo should have the project 'proj'" do
        topic[14].projects = ["proj"]
    end
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
