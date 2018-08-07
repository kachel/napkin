class IdeaController < ApplicationController

  get '/ideas' do
    erb :'/ideas/all_ideas'
  end

end
