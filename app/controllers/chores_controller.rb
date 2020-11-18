class ChoresController < ApplicationController


  # GET: /chores/new
  get "/chores/new" do
    
    @parent = Parent.find_by(:id =>session[:parent_id])
    erb :"/chores/new"
  end

  # POST: /chores
  post "/chores/new" do
    @parent = Parent.find_by(:id =>session[:parent_id])
    @chore = Chore.create(params[:chore])
    redirect "/parents/#{@parent.id}"
  end

  # GET: /chores/5/edit
  get "/chores/:id/edit" do
    erb :"/chores/edit"
  end

  # PATCH: /chores/5
  patch "/chores/:id" do
    redirect "/parents/show"
  end

  # DELETE: /chores/5/delete
  delete "/chores/:id/delete" do
    redirect "/parents/show"
  end
end
