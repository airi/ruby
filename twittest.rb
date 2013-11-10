# -*- coding: utf-8 -*-
require 'rubygems'
require 'twitter'
require 'pp'

Twitter.configure do |cnf|
  cnf.consumer_key = ""
  cnf.consumer_secret = ""
  cnf.oauth_token = ""
  cnf.oauth_token_secret = ""
end

#つぶやき
#Twitter.update("test")

#USERNAME = 'hmtbs_news'
#TARGET = 'airi_jp'
#SOURCE = 'hmtbs_news'

TARGET = ARGV[0]
SOURCE = ARGV[1]

#puts TARGET
#puts SOURCE

#フォロワー取得
#pp Twitter.follower_ids("airi_jp")

#followers = []
count = 0
maxcount = 5

#pp Twitter.followers(USERNAME)

target_ids = Twitter.follower_ids(TARGET).ids
source_ids = Twitter.friend_ids(SOURCE).ids

fan = target_ids - source_ids

fan.each do |id|
  #name = Twitter.user(f).screen_name
  if Twitter.user(id).protected !=true
    #followers.push(id)
    
    #フォロー
    Twitter.follow(id)
    count += 1
  end

  if count >= maxcount
    break
  end
end

rslt = "result: #{count} user followed"
puts rslt


#使わない

=begin
followers.each do |id|
  pp Twitter.user(id).screen_name
end
=end

=begin
Twitter.follower_ids(USERNAME).each do |id|
  #count += 1
  if Twitter.user(id).protected != true 
    count += 1
    followers.push(id)
  end

  if count >= 5 then
    break
  end
end

pp followers
=end
=begin
Twitter.follower_ids(USERNAME).each do |id|
  begin
  #follower_ids.push(id)
    if Twitter.user(id).protected != true
      count += 1
    end
    
  rescue Twitter::Error::TooManyRequests
    puts "rate limit: sleep 15 mins"
    
  #  retry
  #pp Twitter.user(id).protected
  #count +=1
  end
end

pp count

#pp follower_ids 
=end
