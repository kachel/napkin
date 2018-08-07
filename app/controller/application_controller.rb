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

  end

  get '/logout' do

  end

  get '/signup' do
    erb :'users/signup'
  end

  post '/signup' do
    if !params[:email] && !params[:username] && !params[:password]
      @user = User.create(email: params[:email], username: params[:username], password: params[:password))
    else
      redirect to '/signup'
    end
  end

end # ApplicationController
