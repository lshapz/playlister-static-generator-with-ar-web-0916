require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do 
    erb :new
  end 

  get '/posts' do 
    @posts = Post.all 
    erb :index
  end 

  get '/posts/:id' do
    @post = Post.find_by(id: params[:id])
    if Post.all.find_by_id(params[:id]) == nil
      redirect to "/posts/new"
    else
      erb :show
    end 
  end 

  get '/posts/:id/edit' do 
    @post = Post.find_by_id(params[:id])
 
    #@post.save
    erb :edit
  end 

  patch '/posts/:id' do 
    post = Post.find_by_id(params[:id])
    post.name = params[:name]
    post.content = params[:content]
    post.save
    erb :show 
  end 

  post '/posts' do
    @why = Post.create(name: params[:name], content: params[:content])
    #
    redirect to '/posts'
  end 


  delete '/posts/:id/delete' do
    @post = Post.find_by_id(params[:id])
    @thing = @post.name
    @post.delete
    erb :delete
    #redirect to '/posts'
  end 

end