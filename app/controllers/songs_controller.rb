require 'rack-flash'

class SongsController < ApplicationController
    use Rack::Flash

  get '/songs' do
    @songs = Song.all 
    erb :'songs/index'
  end


  get '/songs/new' do 
    erb :'songs/new'
  end 

  post '/songs/new' do
    #binding.pry
    @song = Song.create(name: params["Name"])
    #binding.pry 
    artist = Artist.find_or_create_by(name: params["Artist Name"])
    @song.artist = artist   
    @song.save
    params["genres"].each do |genre|
      new_genre = Genre.find_or_create_by(id: genre) 
      @song.song_genres.build(genre: new_genre) 
    end
    #binding.pry
    @song.save
    #binding.pry
    #slug = @song.slug
    #erb :'songs/show' 
     flash[:message] = "Successfully created song."

    redirect to ("/songs/#{@song.slug}")
   end 


  get '/songs/:slug' do 
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end 

  get '/songs/:slug/edit' do 
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end 


  post '/songs/:slug/edit' do 
    #binding.pry
    @song = Song.find_by_slug(params[:slug])
    @song.name = params["Name"]
    @song.artist = Artist.find_or_create_by(name: params["Artist Name"])
    
    @song.save
    @song.genres.clear 

    params["genres"].each do |genre|
      new_genre = Genre.find_or_create_by(id: genre)
      @song.song_genres.build(genre: new_genre)
    end
    @song.genres.uniq
       #binding.pry
    @song.save
    flash[:message] = "Successfully updated song."
    redirect to ("/songs/#{@song.slug}")
  end 


  # get '/songs/:edit' do 
  #   @song = Song.find_by(id: params[:id])
  #   erb :'songs/edit'
  # end 


  # post '/songs/:id/edit' do 
  #   @song = Song.find_by(id: params[:id])
  #   redirect to '/songs/:id'  
  # end 


end