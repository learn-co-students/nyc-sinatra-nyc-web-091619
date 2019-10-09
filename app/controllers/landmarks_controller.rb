class LandmarksController < ApplicationController
  
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  #FILL FORM for NEW landmark
  get '/landmarks/new' do
    @figures = Figure.all

    erb :'/landmarks/new'
  end

  #CREATE new landmark
  post '/landmarks' do
    @landmark = Landmark.create(params["landmark"])

    if params["figure_name"] != ""
      @landmark.figure_id = Figure.create(name: params["figure_name"]).id
      @landmark.save
    end

    redirect "/landmarks/#{@landmark.id}"
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])

    erb :'/landmarks/show'
  end

  #FILL FORM for UPdate
  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    @figures = Figure.all
    
    erb :'/landmarks/edit'
  end

  patch '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.update(params["landmark"])

    #if we made a new figure
    if params["figure_name"] != ""
      @landmark.figure_id = Figure.create(name: params["figure_name"]).id
      @landmark.save
    end

    redirect "/landmarks/#{@landmark.id}"
  end

  delete '/landmarks/:id' do
    Landmark.destroy(params[:id])
    redirect '/landmarks'
  end

end
