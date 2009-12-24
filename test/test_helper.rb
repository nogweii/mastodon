require 'nanotest'

begin # Optional dependencies
    require 'nanotest/stats'  # Gets some nice speed stats.
    require 'redgreen'        # Pretty colors!
rescue LoadError
end
include Nanotest

# Include the library
require File.dirname(__FILE__) + "/../lib/mastodon.rb"

SAMPLE_TODOS = File.readlines(File.join(File.dirname(__FILE__), "todo.txt")) unless Kernel.const_defined? :SAMPLE_TODOS
@mast = Mastodon.new(SAMPLE_TODOS)
