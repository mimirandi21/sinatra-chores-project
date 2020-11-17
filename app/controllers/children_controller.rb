class ChildrenController < ApplicationController

  # GET: /children
  get "/children" do
    erb :"/children/index"
  end

  # GET: /children/new
  get "/children/new" do
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
    redirect "/children/:id"
  end

  # DELETE: /children/5/delete
  delete "/children/:id/delete" do
    redirect "/children"
  end
end
