require 'test_helper'

# Test searching and caching.
assert { @mast.projects.to_a == ["proj", "proj2", "proj+phone", "proj/foo", "p_r_o_j", "p-r-o-j", "+proj", "@proj"] }
assert { @mast.contexts.to_a == ["con", "con2", "con@phone", "con/foo", "c_o_n", "c-o-n", "@con", "+con"] }

# Finding existing items
assert { @mast.find_context("con2").size  > 0 }
assert { @mast.find_context("con2").first.text == "Multiple contexts" }
assert { @mast.find_project("proj2").size > 0 }
assert { @mast.find_project("proj2").first.text == "Multiple projects" }

# Finding non-existing items
assert { @mast.find_context("nosuchthing") == [] }
assert { @mast.find_project("thisprojectdoesntexist") == [] }

# General utility methods.
assert { @mast.size == SAMPLE_TODOS.size }
# While I can't guarantee a 1:1 match, nothing should be lost. Just possibly rearranged.
assert { (@mast[0].to_s.chars.to_a == SAMPLE_TODOS[0].strip.chars.to_a) and (@mast[0].to_s.length == SAMPLE_TODOS[0].strip.length) }

# Test if correct classes are returned
assert { @mast.projects.is_a? Set }
assert { @mast.contexts.is_a? Set }
assert { @mast[0].is_a? Mastodon::Todo }

# Test if matching at the beginning of a line works
assert { @mast[13].contexts = ["con"] }
assert { @mast[14].projects = ["proj"] }
