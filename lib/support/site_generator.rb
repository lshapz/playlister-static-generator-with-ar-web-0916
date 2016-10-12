require 'fileutils'


class SiteGenerator
  #< ActiveRecord::Migration
  attr_accessor :path, :rendered_path, :artists, :genres, :songs, :render_template, :build_genre_page, :build_artist_page, :build_song_page

  def render_template(template, filename = template)
    html = File.read("./app/views/#{template}.erb")
    doc = ERB.new(html)

    yield if block_given?

    File.open("#{@rendered_path}/#{filename}", "w+") do |f|
      f << doc.result(binding)
    end
  end

  def initialize(path)
    self.rendered_path = path
    FileUtils::mkdir_p self.rendered_path
    FileUtils::mkdir_p "#{self.rendered_path}/songs"
    FileUtils::mkdir_p "#{self.rendered_path}/artists"
    FileUtils::mkdir_p "#{self.rendered_path}/genres"
  end

  def build_index
    render_template("index.html")
  end

  def build_artists_index
    render_template 'artists/index.html' do
      @artists = Artist.all
    end
  end

  def build_songs_index
    render_template 'songs/index.html' do
      @songs = Song.all
    end
  end

  def build_genres_index
    render_template 'genres/index.html' do
      @genres = Genre.all
    end
  end

  # def build_index
  #   render("index.html")
  # end


  # def build_artists_index
  #   render 'artists/index.html' do
  #     @artists = Artist.all
  #   end
  # end

  def build_artist_page 
    Artist.all.each do |x|
      render_template('artists/show.html', "artists/#{x.to_slug}.html").
      end 
  end 

 # def build_genres_index
 #    render 'genres/index.html' do
 #      @genres = Genre.all
 #    end
 #  end

  def build_genre_page 
    Genre.all.each do |x|
      render_template('genres/show.html', "genres/#{x.to_slug}.html")
      end 
    
  end 

 # def build_songs_index
 #    render 'songs/index.html' do
 #      @song = Song.all
 #    end
 #  end

  def build_song_page 
    Song.all.each do |x|
      render_template('songs/show.html', "songs/#{x.to_slug}.html")
      end 
  end 


  def generate
    build_index
    build_artists_index
    build_artist_page
    build_songs_index
    build_song_page
    build_genres_index
    build_genre_page
  end
  # def build_artists_index
  #   render("artists/index.html") do 
  #   @artists = Artist.all 
  # end 
  # end

  # def build_genres_index
  #   render_template("genres/index.html")
  # end

  # def build_songs_index
  #   render_template("songs/index.html")
  # end
  # # def build_index
  # request = Rack::Request.new(rendered_path)
  #   if request.get? && request.path == '/'
  #   template = File.read("./app/views/index.html.erb")
  #   result = ERB.new(template).result(binding)
  #   response = Rack::Response.new(result)
  # end 
  # response 
  # end 


  # def call(env)
  #   # request = Rack::Request.new(env)
  #   # if request.get? && request.path == '/'
  #   #   render('index.html.erb')
  #   # # elsif request.get? && request.path == '/artists' && request.params["id"]
  #   # #   @book = .find(request.params["id"])
  #   # #   render('books/show.html.erb')
  #   if request.get? && request.path == '/artists'
  #     @artists = Artist.all
  #     render('artists/index.html.erb')
  #   elsif request.get? && request.path == '/songs'
  #     @songs = Song.all
  #     render('songs/index.html.erb')
  #   elsif request.get? && request.path == '/genres'
  #     @genres = Genre.all
  #     render('genres/index.html.erb')
  #   else
  #     response = Rack::Response.new('<h1>Nothing here</h1>', 404)
  #   end
  # end


  # def render(file_path)
  #   html = File.read("./app/views/#{file_path}.erb")
  #   result = ERB.new(html).result(binding)
  #   response = Rack::Response.new(result)
  #   File.open("#{@rendered_path}/#{file_path}")
  # end

end
end
