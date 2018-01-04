require 'dotenv'
require 'octokit'
require 'progress_bar'

Dotenv.load

# Defaults
Octokit.auto_paginate = true
Octokit.default_media_type = "application/vnd.github.beta+json"
request_headers = { accept: "application/vnd.github.beta+json" }

# Client configuration
client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])

# Arguments
organization = ARGV[0] 
user = ARGV[1]

# Handle invalid input
unless organization && user
  puts 'Usage:'
  puts '  ruby teamplayer.rb <org> <user>'
  exit(1)
end

# Request data from the API
repos = client.organization_repositories(organization, request_headers)

# Progress bar based on count of repos
bar = ProgressBar.new(repos.count)

# Structure of results
Results = Struct.new(:admin, :write, :read, :none)
results = Results.new([], [], [], [])

puts 'Scanning repositories for permissions ...'

# Loop through the records and add to the return structure
repos.each do |repo|
  permission = client.permission_level(repo.full_name, user, request_headers).permission
  results[permission] << repo
  bar.increment!
end

# Return results
puts ''
puts 'ADMIN'
results['admin'].each do |repo|
  puts "- #{repo.full_name}"
end
puts ''
puts 'WRITE'
results['write'].each do |repo|
  puts "- #{repo.full_name}"
end
puts ''
puts 'READ'
results['read'].each do |repo|
  puts "- #{repo.full_name}"
end
puts ''
puts 'NONE'
results['none'].each do |repo|
  puts "- #{repo.full_name}"
end
