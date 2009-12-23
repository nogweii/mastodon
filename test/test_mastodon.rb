require 'test_helper'

# Test searching and caching.
assert { @mast.projects == ["coding", "testing", "documenting"] }
assert { @mast.contexts == ["work", "people"] }

# Finding existing items
assert { @mast.find_context("work") == ["Finish mastadon +coding @work"] }
assert { @mast.find_project("coding") == ["Finish mastadon +coding @work"] }

# Finding non-existing items
assert { @mast.find_context("nosuchthing") == [] }
assert { @mast.find_project("thisprojectdoesntexist") == [] }

# General utility methods.
assert { @mast.size == SAMPLE_TODOS.size }
assert { @mast[0] == SAMPLE_TODOS[0] }

# Test if correct classes are returned
assert { @mast.projects.is_a? Array }
assert { @mast.contexts.is_a? Array }
assert { @mast[0].is_a? Mastodon::Todo }
