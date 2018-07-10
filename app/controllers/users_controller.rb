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
        elsif session[:selected_mood] == 'moody'
            return redirect_to user_moody_path
        
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
            ids = %w(0ijhkvBpA7OBlY4clWSUZw 4k6ktr10Hczmh55NY3LfJy 0d28khcov6AiegSCpG5TuT 5at039gZfHTvOK3gSLni5m 5b88tNINg4Q4nrRbrCXUmg 5X82VFLvjpeWQlTSShqqj0 5A5Ej8R3QY9xb98dmVowmL 3YhMQEplRrfFcdkpazT5aq 6CbcdeTQKj0qTaZTt0xkdk 0G3fbPbE1vGeABDEZF0jeG)
            tracks = RSpotify::Base.find(ids, 'track')
            @playlist.add_tracks!(tracks)
        else
            @playlist = matches
        end

    end


    def sad

        # using hash to access user's spotify account
        # MUST add "@" in order to access instance in ERB
        @spotify_user =  RSpotify::User.new(session[:spotify_user_hash])
        @playlists = @spotify_user.playlists
        
        #start matches with no value
        matches = nil

        #loop through all the playlists to check if names match. if match then equals p
        @playlists.each do |p|
            matches = p if p.name == "SAD AF"
        end

        #if there are no matches then the playlist is created
        if matches == nil
            @playlist = @spotify_user.create_playlist!('SAD AF')

            # Currated tracks added to playlist in user's Spotify account
            ids = %w(19YKaevk2bce4odJkP5L22 1iYqDZIz3sNCmplcZoc2t3 3MacKrBQf7wsyU2GiIxWVw 6FBlxkA9VKafooUNAi4W3p 2IU9XtrbGviQfWAjg4x9kc 1gm616Plq4ScqNi7TVkZ5N 54oMZ3blwWwuPN4wEoG5mk 07sp7WMebghQBBMDCCyEvw 3pS7mYhFMZ6MmeSpKXzfJR 3TNzMvWUuNoeyBcNeUQZH4)
            tracks = RSpotify::Base.find(ids, 'track')
            @playlist.add_tracks!(tracks)
        else
            @playlist = matches
        end
        
    end

    def moody

        @spotify_user =  RSpotify::User.new(session[:spotify_user_hash])
        @playlists = @spotify_user.playlists
        
        matches = nil

        @playlists.each do |p|
            matches = p if p.name == "MOODY AF"
        end

        if matches == nil
            @playlist = @spotify_user.create_playlist!('MOODY AF')

            ids = %w(0w1ZtnzQmtmuuoKxHT0pLL 38HcgcQC4suvti0Sa0e5yc 6J3YPOejivwLSjM2dru5Ad 41Auep8o0Fv5Q21qiF4OZv 3ZYwSDF9knZI0RVlKR4PHC 3q6ygCZID0OKj6MUxInB48 7c3yQ5FuVNAY5qMjTwzLzx 08vwr6ulz3MqPzgCJ5TbyV 0AQj76XKZkJRbtnPL6RzSc 5BeZELzAySW7mN4aHswS5I)
            tracks = RSpotify::Base.find(ids, 'track')
            @playlist.add_tracks!(tracks)
        else
            @playlist = matches
        end

    end

end
