module SongsHelper
  def artist_id_field(song)
    if params[:artist_id]
      hidden_field_tag 'artist_id', params[:artist_id]
    else
      select_tag "song_artist_id", options_from_collection_for_select(Artist.all, :id, :name)
    end
  end
end
