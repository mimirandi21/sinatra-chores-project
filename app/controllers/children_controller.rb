class ChildrenController < ApplicationController

  
  # GET: /children/new
  get "/children/new" do
    @parent = Parent.find_by(:id =>session[:parent_id])
    erb :"/children/new"
  end

  # POST: /children
  post "/children" do
    redirect "/children"
  end

  # GET: /children/5
  get "/children/:id" do
    erb :"/children/show"
  end

  # GET: /children/5/edit
  get "/children/:id/edit" do
    erb :"/children/edit"
  end

  # PATCH: /children/5
  patch "/children/:id" do
    redirect "/parents/show"
  end

  # DELETE: /children/5/delete
  delete "/children/:id/delete" do
    redirect "/parents/show"
  end
end
