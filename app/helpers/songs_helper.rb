module SongsHelper
	def artist_select(f, song)
		if song.artist_id
  			f.hidden_field(:artist_id)
  		else	
  			f.collection_select(:artist_id, Artist.all, :id, :name, :prompt => "Select An Artist")
  		end
  	end
  	def if_artist
  		if @artist
  			new_artist_song_path(@artist)
  		else
  			new_song_path 
  		end
  	end
end
