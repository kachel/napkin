require 'rack-flash'
class IdeaController < ApplicationController
  use Rack::Flash

  get '/ideas' do
    if logged_in?
      @user = current_user
      @ideas = Idea.all
      erb :'/ideas/all_ideas'
    else
      redirect to '/login'
    end
  end

  get '/ideas/new' do
    if logged_in?
      @user = current_user
      erb :'ideas/new_idea'
    else
      redirect to '/login'
    end
  end

  post '/ideas' do
    if !params[:project].empty?
      @idea = Idea.create(project: params[:project], user_id: current_user.id)
      flash[:message] = "Successfully created project."
      erb :'/ideas/show'
    else
      redirect '/ideas/new'
    end
  end

  get '/ideas/:id' do
    if logged_in?
      @idea = Idea.find(params[:id])
      erb :'/ideas/show'
    else
      redirect '/login'
    end
  end

  get '/ideas/:id/edit' do
    if logged_in?
      @idea = Idea.find(params[:id])
      erb :'/ideas/edit_idea'
    else
      redirect '/login'
    end
  end

  patch '/ideas/:id' do
    @idea = Idea.find(params[:id])
    if !params[:project].empty?
      @idea.project = params[:project]
      @idea.save
      flash[:message] = "Successfully edited project."
      erb :'ideas/show'
    else
      redirect "/ideas/#{@idea.id}/edit"
    end
  end

  get '/ideas/:id/delete' do
    @idea = Idea.find(params[:id])
    if logged_in?
      if @idea.user_id == current_user.id
        @user = current_user
        @idea.delete
        @ideas = Idea.all
        flash[:message] = "Successfully deleted project."
        erb :'/ideas/show'
      end
    else
      redirect '/login'
    end
  end

end # IdeaController
