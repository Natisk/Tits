require 'pusher'

Pusher.url = 'http://b15da0d38e1cf270a7b1:a8e7ec425dac974f5bb7@api.pusherapp.com/apps/55139'

# ---- if using slanger-------
#Pusher.logger = Rails.logger#
#Pusher.app_id = Settings.pusher.app_id
#Pusher.key = Settings.pusher.key
#Pusher.secret = Settings.pusher.secret
#Pusher.host = Settings.pusher.api_host
#Pusher.port = Settings.pusher.port

# ---- first check if pusher works--------
#Pusher['test_channel'].trigger('my_event', {
#  message: 'hello world'
#})
