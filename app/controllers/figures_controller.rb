class FiguresController < ApplicationController
  
  get '/figures' do
    @figures = Figure.all
    erb :'figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all

    erb :'/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(name: params["figure"]["name"])
  

    # If we checked off some landmarks
    if params["figure"]["landmark_ids"]
     
      params["figure"]["landmark_ids"].each do |landmark_id|
        Landmark.find(landmark_id).update(figure_id: @figure.id)
      end
    end

    #If we created a new landmark
    if params["landmark"]["name"] != ""
   
      Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"], figure_id: @figure.id)
    end

    #if we checked some existing titles, create a FigureTitle
    if params["figure"]["title_ids"]
     
      params["figure"]["title_ids"].each do |title_id|
        FigureTitle.create(title_id: title_id, figure_id: @figure.id )
      end
    end

    #if we created a title, create a Title and FigureTitle
    if params["title"]["name"] != ""
      
      @title = Title.create(params["title"])
      FigureTitle.create(title_id: @title.id, figure_id: @figure.id )
    end

    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    @landmarks = @figure.landmarks
    @titles = @figure.titles

    erb :'figures/show'
  end

  get '/figures/:id/edit' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure = Figure.find(params[:id])
    
    erb :'figures/edit'

  end

  patch '/figures/:id' do
    @figure = Figure.find(params[:id])
    
    @figure.update(params["figure"])
  

    # If we checked off some landmarks
    if params["figure"]["landmark_ids"]
      params["figure"]["landmark_ids"].each do |landmark_id|
        Landmark.find(landmark_id).update(figure_id: @figure.id)
      end
    end

    #If we created a new landmark
    if params["landmark"]["name"] != ""
      Landmark.create(name: params["landmark"]["name"], year_completed: params["landmark"]["year_completed"], figure_id: @figure.id)

    end

    #if we checked some existing titles, create a FigureTitle
    if params["figure"]["title_ids"]
      params["figure"]["title_ids"].each do |title_id|
        if !@figure.titles.include?(Title.find(title_id))
          FigureTitle.create(title_id: title_id, figure_id: @figure.id )
        end
      end
    end

    #if we created a title, create a Title and FigureTitle
    if params["title"]["name"] != ""
      @title = Title.create(params["title"])
      FigureTitle.create(title_id: @title.id, figure_id: @figure.id )
    end
    
    redirect "/figures/#{@figure.id}"
  end

  delete '/figures/:id' do
    
  end


end
