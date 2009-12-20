require 'test_helper'

assert { @mast.projects == ["coding", "testing", "documenting"] }
assert { @mast.contexts == ["work", "phone", "home"] }
assert { @mast.find(:context => "work") == ["work"] }
assert { @mast.find(:project => "coding") == ["work"] }
assert { @mast.size == 3 }
assert { @mast[0] == "blah" }
