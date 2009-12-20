require 'test_helper'

# Test searching and caching.
assert { @mast.projects == ["coding", "testing", "documenting"] }
assert { @mast.contexts == ["work", "phone", "home"] }

# Finding existing items
assert { @mast.find_context("work") == ["work"] }
assert { @mast.find_project("coding") == ["work"] }

# Finding non-existing items
assert { @mast.find_context("nosuchthing") == [] }
assert { @mast.find_project("thisprojectdoesntexist") == [] }

# General utility methods.
assert { @mast.size == 3 }
assert { @mast[0] == "Finish mastadon +coding" }
