# frozen_string_literal: true

spec = Gem::Specification.load('shelvit.gemspec')

spec.development_dependencies.each do |dependency|
  system('gem', 'list', '--remote', '--exact', dependency.name)
end

spec.runtime_dependencies.each do |dependency|
  system('gem', 'list', '--remote', '--exact', dependency.name)
end
