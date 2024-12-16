require('config.set')
require('config.remap')

require('config.lazy')

-- Load after lazy, as there are `require` statements
require('config.filetype')
