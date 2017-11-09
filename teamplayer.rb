require 'dotenv'
require 'octokit'

Dotenv.load

# Defaults
Octokit.auto_paginate = true

# Client configuration
client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])

# Arguments
organization = ARGV[0] 
user = ARGV[1]

def show_usage
  puts 'Usage:'
  puts '  ruby teamplayer.rb <org> <user>'
end

unless organization && user
  show_usage
  exit(1)
end

client.organization_repositories(organization).each do |repo|
  permission = client.permission_level(repo.full_name, user).permission
  puts "#{permission}\t#{repo.full_name}"
end
