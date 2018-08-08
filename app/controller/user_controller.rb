# logging in and out?
class UserController < ApplicationController

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
     if logged_in?
        session.clear
        redirect to '/login'
     else
        redirect to '/'
     end
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

end
