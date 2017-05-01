#!/usr/bin/env ruby
# encoding: utf-8

# Uses the following Slack API methods:
# user.list → https://api.slack.com/methods/users.list
# channels.history → https://api.slack.com/methods/channels.history
require "open-uri"
require "json"

# Obtain a token
# https://api.slack.com/docs/oauth-test-tokens
TOKEN = ""
# Find out the channel ID
# https://api.slack.com/methods/channels.history/test
CHANNEL = ""

# Obtain logs
more = true
messages = Array.new
last = ""
# loop over pages until we reach the end of time
while more == true do 
  data = open("https://slack.com/api/channels.history?token=#{TOKEN}&channel=#{CHANNEL}&count=1000&latest=#{last}").read
  data = JSON.parse(data)
  messages << data["messages"]
  more = data["has_more"]
  last = data["messages"].last["ts"]
end
messages.flatten!
# sort messages oldest → newest
messages.sort_by!{ |msg| msg["ts"] }

# Obtain user data
user_data = open("https://slack.com/api/users.list?token=#{TOKEN}").read
user_data = JSON.parse(user_data)

# Make a hash of IDs → Names
slack_users = Hash.new
user_data["members"].each do |member|
  slack_users[member["id"]] = member["name"]
end

# Write the logs to disk
File.open("slack.log", "a+") do |file|
  messages.each do |line|
    # ignore unnecessary metadata
    next if line.has_key?("subtype")

    timestamp = Time.at(line["ts"].to_i)
    user = slack_users[line["user"]]
    message = line["text"].gsub(/\s+/, " ")

    # replace user IDs with Names
    if message =~ /<@\w+>/
      mentions = message.scan(/<@(\w+)>/)
      mentions.flatten!
      mentions.each do |mention|
        message.gsub!("<@#{mention}>", slack_users[mention])
      end
    end

    file.puts("[#{timestamp}] <#{user}> #{message}")
  end
end