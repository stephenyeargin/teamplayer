require 'dotenv'
require 'octokit'

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

def show_usage
  puts 'Usage:'
  puts '  ruby teamplayer.rb <org> <user>'
end

unless organization && user
  show_usage
  exit(1)
end

client.organization_repositories(organization, request_headers).each do |repo|
  permission = client.permission_level(repo.full_name, user, request_headers).permission
  puts "#{permission}\t#{repo.full_name}"
end
