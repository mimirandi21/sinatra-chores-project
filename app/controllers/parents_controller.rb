class ParentsController < ApplicationController


  # GET: /parents/new
  get "/parents/new" do
    erb :"/parents/new"
  end

  # POST: /parents
  post "/parents" do
    redirect "/parents"
  end

  # GET: /parents/5
  get "/parents/:id" do
    @chores = Chore.where(:parent_id => session[:parent_id])
    @children = Child.where(:parent_id => session[:parent_id])
    @parent = Parent.find_by_id(session[:parent_id])
    
    erb :"/parents/show"
  end

  # GET: /parents/5/edit
  get "/parents/:id/edit" do
    @parent = Parent.find_by_id(params[:id])
    erb :"/parents/edit"
  end

  # PATCH: /parents/5
  patch "/parents/:id" do
    redirect "/parents/:id"
  end

  # DELETE: /parents/5/delete
  delete "/parents/:id/delete" do
    redirect "/parents"
  end

  
end
