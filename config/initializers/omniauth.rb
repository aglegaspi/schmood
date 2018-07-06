require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  # update scope in order to give client access to spotify api featured such as playlist create and streaming
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"], scope: 'user-read-email playlist-modify-public user-library-read user-library-modify streaming user-read-birthdate user-read-email user-read-private'
end

