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
        # MUST add "@" in order to access instance in ERB
        @spotify_user =  RSpotify::User.new(session[:spotify_user_hash])
        @playlists = @spotify_user.playlists
        
        #start matches with no value
        matches = nil

        #loop through all the playlists to check if names match. if match then equals p
        @playlists.each do |p|
            matches = p if p.name == "Happy AF"
        end

        #if there are no matches then the playlist is created
        if matches == nil
            @playlist = @spotify_user.create_playlist!('Happy AF')

            # Currated tracks added to playlist in user's Spotify account
            ids = %w(2tUBqZG2AbRi7Q0BIrVrEj 4k6ktr10Hczmh55NY3LfJy 0d28khcov6AiegSCpG5TuT 5at039gZfHTvOK3gSLni5m 5b88tNINg4Q4nrRbrCXUmg 5X82VFLvjpeWQlTSShqqj0 5A5Ej8R3QY9xb98dmVowmL 3YhMQEplRrfFcdkpazT5aq 6CbcdeTQKj0qTaZTt0xkdk 0G3fbPbE1vGeABDEZF0jeG)
            tracks = RSpotify::Base.find(ids, 'track')
            @playlist.add_tracks!(tracks)
        else
            @playlist = matches
        end

    end


    def sad

        @spotify_user =  RSpotify::User.new(session[:spotify_user_hash])
        @playlists = @spotify_user.playlists
        
        matches = nil

        @playlists.each do |p|
            if p.name == "Sad AF"
                matches = p
            end

        end

        if matches == nil
            playlist = @spotify_user.create_playlist!('Sad AF')

            ids = %w(2IU9XtrbGviQfWAjg4x9kc 19YKaevk2bce4odJkP5L22 1gm616Plq4ScqNi7TVkZ5N 2F4JaV4P4zajoAiUkHD36b 29zBeRiLVnkDEj7tvmLVOU 1iYqDZIz3sNCmplcZoc2t3 07sp7WMebghQBBMDCCyEvw 6FBlxkA9VKafooUNAi4W3p 3MacKrBQf7wsyU2GiIxWVw 3TNzMvWUuNoeyBcNeUQZH4)
            tracks = RSpotify::Base.find(ids, 'track')
            playlist.add_tracks!(tracks)
        end

    end

end
