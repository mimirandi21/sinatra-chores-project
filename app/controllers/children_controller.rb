require 'sinatra/base'
require 'rack-flash'

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
    binding.pry
    redirect "/parents/#{@parent.id}"
  end

  # GET: /children/5/edit
  get "/children/:id/edit" do
    @child = Child.find_by_id(params[:id])
    @parent = Parent.find_by(:id =>session[:parent_id])
    erb :"/children/edit"
  end

  # PATCH: /children/5
  patch "/children/:id" do
    @parent = Parent.find_by(:id =>session[:parent_id])
    child = Child.find_by_id(params[:id])
    child.update(params[:child])
    flash[:message] = "Child successfully updated."
    redirect "/parents/#{@parent.id}"
  end

  get '/children/:id/delete' do
    @parent = Parent.find_by(:id =>session[:parent_id])
    @child = Child.find(params[:id])
    erb :"/children/delete"
  end
  # DELETE: /children/5/delete
  delete "/children/:id" do
    @parent = Parent.find_by(:id =>session[:parent_id])
    child = Child.find_by_id(params[:id])
    
    child.destroy
    flash[:message] = "Child successfully left the nest."
    redirect "/parents/#{@parent.id}"
  end
end
