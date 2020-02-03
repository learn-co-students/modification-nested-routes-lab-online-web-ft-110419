class SongsController < ApplicationController
  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    @song = Song.new
    if params[:artist_id] 
      if Artist.exists?(params[:artist_id].to_i)
        @song.artist_id = params[:artist_id].to_i
      else
        flash[:alert] = "Artist not found."
        redirect_to artists_path 
      end
    end
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find_by_id(params[:id])
    if !params[:artist_id].blank?
      if !Artist.exists?(params[:artist_id].to_i)
        flash[:alert] = "Artist not found."
        redirect_to artists_path
      elsif !@song || @song.artist.id != params[:artist_id].to_i
        flash[:alert] = "Song not found."
        redirect_to artist_songs_path(params[:artist_id].to_i)
      end
    elsif !@song 
      flash[:alert] = "Song not found."
      redirect_to songs_path 
    end
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end

