# frozen_string_literal: true

require_relative 'lib/shelvit/version'

Gem::Specification.new do |spec|
  spec.name          = 'shelvit'
  spec.version       = Shelvit::VERSION
  spec.authors       = ['Adam Wead', 'Nick Tiberi']
  spec.email         = ['nicktiberi@gmail.com']

  spec.summary       = 'Generates normalized shelf keys from call numbers, using the Lcsort gem.'
  spec.description   = 'Shelvit extends the functionality of Lcsort by cleaning unsortable call'\
                       'numbers before attempting to normalize them again.'
  spec.license       = 'MIT'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6.0'

  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 1.7'

  spec.add_runtime_dependency 'lcsort', '~> 0.9'
end
