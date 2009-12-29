# Mastodon
A [todo.txt][ttxt] parser.

[ttxt]: http://ginatrapani.github.com/todo.txt-cli/

## Installation

    sudo gem install mastodon

## Usage

    require 'mastodon'
    mast = Mastodon.new(File.readlines("todo.txt"))
    # List all the projects
    mast.projects
    # List all the contexts
    mast.contexts


## See Also
There are other links you can take a look at. If you care to, that is.

 * [Run Code Run][rcr] (continuous integration)
 * [Caliper & metric\_fu report][calip]
 * [RDoc.info Documentation][rdoci] ([yardoc.org][yardoc])

[rcr]: http://runcoderun.com/evaryont/mastodon
[calip]: http://getcaliper.com/caliper/project?repo=git%3A%2F%2Fgithub.com%2Fevaryont%2Fmastodon.git
[rdoci]: http://rdoc.info/projects/evaryont/mastodon
[yardoc]: http://yardoc.org/docs/evaryont-mastodon

## Copyright
Mastodon is released under the MIT license. Copyright (C) Colin Shea 2009. For
more information, consult LICENSE.txt for more information.
