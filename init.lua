-- opts/settings
require('config.set')

-- lazy plugin manager
require('config.lazy')

-- Remapping/Keymapping
require('config.remap')

-- !! Load after lazy, as there are `require` statements
require('config.filetype')
