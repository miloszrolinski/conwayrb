require './lib/conwayrb/version.rb'

Gem::Specification.new do |spec|
  spec.name = 'conwayrb'
  spec.version = CONWAYRB_VERSION
  spec.date = '2015-06-28'
  spec.summary = 'Conway\'s Game of life'
  spec.description = 'An implementation of Conway\'s "Game of Life" in Ruby and GTK3'
  spec.authors = ['Miłosz Roliński']
  spec.email = ['rolinski.m@gmail.com']
  spec.license = 'GPL-3.0'
  spec.files = ['lib/conway.rb',
                'lib/conwayrb/deps.rb',
                'lib/conwayrb/cells.rb',
                'lib/conwayrb/cell_table.rb',
                'lib/conwayrb/game.rb',
                'lib/conwayrb/window.rb',
                'lib/conwayrb/settings.rb',
                'lib/conwayrb/option.rb',
                'lib/conwayrb/controls.rb',
                'assets/circle.png',
                'assets/cross.png' ]
  spec.executables << 'conwayrb'
  spec.add_runtime_dependency('gtk3', '~> 2.2')
  spec.homepage = 'https://github.com/cookieburra/conwayrb'
end
