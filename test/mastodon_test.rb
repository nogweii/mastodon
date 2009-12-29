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
        (@mast[0].to_s.chars.to_a == SAMPLE_TODOS[0].strip.chars.to_a) and (@mast[0].to_s.length == SAMPLE_TODOS[0].strip.length)
    end
    asserts "There should be the same amount of todos" do
        @mast.size == SAMPLE_TODOS.size
    end
    asserts "project should be returned as a Set" do
        @mast.projects.is_a? Set
    end
    asserts "context should be returned as a Set" do
        @mast.contexts.is_a? Set
    end
    asserts "Confirm that the retrieved todos are of type Mastodon::Todo" do
        @mast[0].is_a? Mastodon::Todo
    end
    asserts "13th todo should have the context 'con'" do
        @mast[13].contexts = ["con"]
    end
    asserts "14th todo should have the project 'proj'" do
        @mast[14].projects = ["proj"]
    end
    asserts "Third todo should have no priority" do
        @mast[3].priority.nil?
    end
    asserts "Fourth todo should have no priority" do
        @mast[4].priority.nil?
    end
    asserts "Fifth todo should have priority A" do
        @mast[5].priority = "A"
    end
    asserts "Sixth todo should have priority Z" do
        @mast[6].priority = "Z"
    end
    asserts "Seventh todo should have priority Q" do
        @mast[7].priority = "Q"
    end
    asserts "Eighth todo should have no priority" do
        @mast[8].priority.nil?
    end
end
