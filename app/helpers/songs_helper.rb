module SongsHelper

    def song_artist_id(song)
        if song.artist.nil?
            # Make sure there is no blank author 
          select_tag "song[artist_id]", options_from_collection_for_select(Artist.all, :id, :name)
        else
            # add this hidden_field below
          hidden_field_tag "song[artist_id]", song.artist_id
        end
    end

end
