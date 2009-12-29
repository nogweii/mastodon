require 'teststrap'

@todos = File.readlines(File.join(File.dirname(__FILE__), "todo.txt"))

context "Mastodon" do
    setup do
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

    asserts { topic.find_context("con2").size  > 0 }
    asserts { topic.find_context("con2").first.text == "Multiple contexts" }
    asserts { topic.find_project("proj2").size > 0 }
    asserts { topic.find_project("proj2").first.text == "Multiple projects" }

    asserts { (@mast[0].to_s.chars.to_a == SAMPLE_TODOS[0].strip.chars.to_a) and (@mast[0].to_s.length == SAMPLE_TODOS[0].strip.length) }
    asserts { @mast.size == SAMPLE_TODOS.size }
    asserts { @mast.projects.is_a? Set }
    asserts { @mast.contexts.is_a? Set }
    asserts { @mast[0].is_a? Mastodon::Todo }
    asserts { @mast[13].contexts = ["con"] }
    asserts { @mast[14].projects = ["proj"] }
    asserts { @mast[3].priority.nil?  }
    asserts { @mast[4].priority.nil?  }
    asserts { @mast[5].priority = "A" }
    asserts { @mast[6].priority = "Z" }
    asserts { @mast[7].priority = "Q" }
    asserts { @mast[8].priority.nil?  }
end
