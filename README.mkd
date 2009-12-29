# Mastodon
A [todo.txt][1] parser.

[1]: http://ginatrapani.github.com/todo.txt-cli/

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

 * [Run Code Run][1] (continuous integration)
 * [Caliper & metric\_fu report][2]

[1]: http://runcoderun.com/evaryont/mastodon
[2]: http://getcaliper.com/caliper/project?repo=git%3A%2F%2Fgithub.com%2Fevaryont%2Fmastodon.git

## Copyright
Mastodon is released under the MIT license. Copyright (C) Colin Shea 2009. For
more information, consult LICENSE.txt for more information.
