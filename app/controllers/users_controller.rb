class UsersController < ApplicationController

    def spotify_intercept
        #we create a session which takes in the user's mood
        session[:selected_mood] = params[:user_mood]
        redirect_to '/auth/spotify'
    end

    def user_mood
        #instance for the current spotify user
        spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
        #create a hash in order to access again on other methods
        session[:spotify_user_hash] = spotify_user.to_hash

        #these redirect user accoring to mood
        if session[:selected_mood] == 'happy'
            return redirect_to user_happy_path
        elsif session[:selected_mood] == 'sad'
            return redirect_to user_sad_path
        elsif session[:selected_mood] == 'angry'

        elsif session[:selected_mood] == 'moody'

        end
    end


    def happy
        # using hash to access user's spotify account
        spotify_user =  RSpotify::User.new(session[:spotify_user_hash])
        
        # Create playlist in user's Spotify account
        playlist = spotify_user.create_playlist!('Happy AF')

        # Currated tracks added to playlist in user's Spotify account
        ids = %w(2tUBqZG2AbRi7Q0BIrVrEj 4k6ktr10Hczmh55NY3LfJy 0d28khcov6AiegSCpG5TuT 5at039gZfHTvOK3gSLni5m 5b88tNINg4Q4nrRbrCXUmg 5X82VFLvjpeWQlTSShqqj0 5A5Ej8R3QY9xb98dmVowmL 3YhMQEplRrfFcdkpazT5aq 6CbcdeTQKj0qTaZTt0xkdk 0G3fbPbE1vGeABDEZF0jeG)
        tracks = RSpotify::Base.find(ids, 'track')
        playlist.add_tracks!(tracks)

    end

    def sad
        # using hash to access user's spotify account
        spotify_user =  RSpotify::User.new(session[:spotify_user_hash])
        
        # Create playlist in user's Spotify account and NAME OF PLAYLIST
        playlist = spotify_user.create_playlist!('Sad AF')

        # Add tracks to a playlist in user's Spotify account
        ids = %w(2tUBqZG2AbRi7Q0BIrVrEj 4k6ktr10Hczmh55NY3LfJy 0d28khcov6AiegSCpG5TuT 5at039gZfHTvOK3gSLni5m 5b88tNINg4Q4nrRbrCXUmg 5X82VFLvjpeWQlTSShqqj0 5A5Ej8R3QY9xb98dmVowmL 3YhMQEplRrfFcdkpazT5aq 6CbcdeTQKj0qTaZTt0xkdk 0G3fbPbE1vGeABDEZF0jeG)
        tracks = RSpotify::Base.find(ids, 'track')
        playlist.add_tracks!(tracks)

    end

end
