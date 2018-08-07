class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "no_pass"
  end

  get '/' do
   erb :'index'
  end

  get '/login' do
    if logged_in?
      redirect to '/ideas'
    else
      erb :'users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session["user_id"] = @user.id
      redirect '/ideas'
    else
      redirect '/login'
    end
  end

  get '/logout' do

  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    if !params[:email].empty? && !params[:username].empty? && !params[:password].empty?
      @user = User.create(email: params[:email], username: params[:username], password: params[:password])
      redirect to '/ideas'
    else
      redirect to '/signup'
    end
  end

  helpers do
  	def logged_in?
  		!!session[:user_id]
  	end

  	def current_user
  		User.find(session[:user_id])
  	end

  end

end # ApplicationController
