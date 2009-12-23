require 'test_helper'

# Test searching and caching.
assert { @mast.projects.to_a == ["coding", "testing", "documenting"] }
assert { @mast.contexts.to_a == ["work", "people"] }

# Finding existing items
assert { @mast.find_context("work") == ["Finish mastadon +coding @work"] }
assert { @mast.find_project("coding") == ["Finish mastadon +coding @work"] }

# Finding non-existing items
assert { @mast.find_context("nosuchthing") == [] }
assert { @mast.find_project("thisprojectdoesntexist") == [] }

# General utility methods.
assert { @mast.size == SAMPLE_TODOS.size }
# While I can't guarantee a 1:1 match, nothing should be lost. Just possibly rearranged.
assert { (@mast[0].to_s.chars.to_a == SAMPLE_TODOS[0].chars.to_a) and (@mast[0].length == SAMPLE_TODOS[0].length) }

# Test if correct classes are returned
assert { @mast.projects.is_a? Set }
assert { @mast.contexts.is_a? Set }
assert { @mast[0].is_a? Mastodon::Todo }
