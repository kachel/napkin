class IdeaController < ApplicationController

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
      erb :'/ideas/show'
    else
      redirect '/ideas/new'
    end
  end
end
