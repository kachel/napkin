require 'rack-flash'
class UserController < ApplicationController
  use Rack::Flash

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
      unless User.find_by(username: params[:username])
        @user = User.create(email: params[:email], username: params[:username], password: params[:password])
        session["user_id"] = @user.id
        redirect to '/ideas'
      else
        redirect to '/signup'
      end
    else
      redirect to '/signup'
    end
  end

end
