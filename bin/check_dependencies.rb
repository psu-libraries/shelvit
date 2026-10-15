# frozen_string_literal: true

require 'net/http'
require 'json'

result = {}

lines = File.readlines(File.expand_path('../shelvit.gemspec', __dir__))
lines = lines.each(&:strip!)
lines = lines.select do |l|
  l.start_with?('spec.add_development_dependency') || l.start_with?('spec.add_runtime_dependency')
end

lines.each do |l|
  dependency = l.split[1].tr("'", '').tr(',', '')

  uri = URI("https://rubygems.org/api/v1/gems/#{dependency}.json")
  response = Net::HTTP.get_response(uri)

  if response.code == '200'
    data = JSON.parse(response.body)
    version = data['version']

    result[dependency] = version
  else
    puts "Request for #{dependency} failed with status #{response.code}"
  end
end

result.each do |key, value|
  puts "'#{key}', '~> #{value}'"
end
