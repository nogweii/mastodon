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
    "Todo @con +proj",
    "left @ right @con",
    "user@server email",
    "Multiple projects +proj +proj2",
    "Multiple contexts @con @con2",
    "(A) Priority",
    "(Z) All the way to Z",
    "Not a priority: (A)",
    "(Q) All mixed together @con +proj",
    "Advanced contexts @con@phone @con/foo @c_o_n @c-o-n @@con",
    "Advanced projects +con+phone +con/foo +c_o_n +c-o-n ++proj",
    "Mixed symbols: +@proj @+con",
    "@con Leading with a context",
    "+proj Leading with a project"
] unless Kernel.const_defined? :SAMPLE_TODOS
@mast = Mastodon.new(SAMPLE_TODOS)

include Nanotest
