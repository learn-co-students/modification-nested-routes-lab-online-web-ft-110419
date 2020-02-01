module SongsHelper

    def artist_select(artist_song)
        if artist_song
            artist_song.artist.name
        else
            select_tag "song_artist_id", options_from_collection_for_select(Artist.all, "id", "name")
        end     
    end

end
