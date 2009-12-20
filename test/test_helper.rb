# Testing framework {{{
require 'nanotest'
# Optional testing dependency: nanotest_extensions
# Gets some nice speed stats.
begin
    require 'nanotest/stats'
rescue LoadError
end
# Optional testing dependency: redgreen
# Pretty colors!
begin
    require 'redgreen'
rescue LoadError
end
# }}}

# Include the library
require File.dirname(__FILE__) + "/../lib/mastodon.rb"

SAMPLE_TODOS = [
    "Finish mastadon +coding @work",
    "Spec 100% +testing @people",
    "Document 100% +documenting"
] unless Kernel.const_defined? :SAMPLE_TODOS
@mast = Mastodon.new(SAMPLE_TODOS)

include Nanotest
