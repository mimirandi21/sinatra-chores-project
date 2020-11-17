class ChoresController < ApplicationController

  # GET: /chores
  get "/chores" do
    erb :"/chores/index"
  end

  # GET: /chores/new
  get "/chores/new" do
    erb :"/chores/new"
  end

  # POST: /chores
  post "/chores" do
    redirect "/chores"
  end

  # GET: /chores/5
  get "/chores/:id" do
    erb :"/chores/show"
  end

  # GET: /chores/5/edit
  get "/chores/:id/edit" do
    erb :"/chores/edit"
  end

  # PATCH: /chores/5
  patch "/chores/:id" do
    redirect "/chores/:id"
  end

  # DELETE: /chores/5/delete
  delete "/chores/:id/delete" do
    redirect "/chores"
  end
end
