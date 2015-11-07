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
                'assets/circle_25px.png',
                'assets/cross_25px.png',
                'assets/circle_50px.png',
                'assets/cross_50px.png', 
                'lib/conwayrb/cell_button.rb',
                'lib/conwayrb/cell_table.rb',
                'lib/conwayrb/cells.rb',
                'lib/conwayrb/controls.rb',
                'lib/conwayrb/deps.rb',
                'lib/conwayrb/option/option_combo.rb',
                'lib/conwayrb/option/option_entry.rb',
                'lib/conwayrb/option/option.rb',
                'lib/conwayrb/settings.rb',
                'lib/conwayrb/version.rb',
                'lib/conwayrb/window.rb']
  spec.executables << 'conwayrb'
  spec.add_runtime_dependency('gtk3', '~> 2.2')
  spec.homepage = 'https://github.com/cookieburra/conwayrb'
end
