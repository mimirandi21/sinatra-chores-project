require 'sinatra/base'
require 'rack-flash'

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
    @parent = Parent.find_by_id(params[:id])
    @parent.update(params[:parent])
    flash[:message] = "Your account has been updated."
    redirect :"/parents/#{@parent.id}"
  end

  get '/parents/:id/delete' do
    @parent = Parent.find(params[:id])
    erb :"/parents/delete"
  end
  # DELETE: /parents/5/delete
  delete "/parents/:id" do
    parent = Parent.find_by_id(params[:id])
    parent.destroy
    redirect "/"
  end

  
end
