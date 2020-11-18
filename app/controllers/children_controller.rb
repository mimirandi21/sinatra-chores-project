class ChildrenController < ApplicationController

  
  # GET: /children/new
  get "/children/new" do
    @parent = Parent.find_by(:id =>session[:parent_id])
    erb :"/children/new"
  end

  # POST: /children
  post "/children/new" do
    @parent = Parent.find_by(:id =>session[:parent_id])
    @child = Child.create(params[:child])
    @child.parent_id = @parent.id
    @child.save
    redirect "/parents/#{@parent.id}"
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
    @parent = Parent.find_by(:id =>session[:parent_id])
    redirect "/parents/#{@parent.id}"
  end

  # DELETE: /children/5/delete
  delete "/children/:id/delete" do
    @parent = Parent.find_by(:id =>session[:parent_id])
    redirect "/parents/#{@parent.id}"
  end
end
