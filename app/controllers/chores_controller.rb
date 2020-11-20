require 'sinatra/base'
require 'rack-flash'

class ChoresController < ApplicationController

  get "/chores/:id/take" do
    @child = Child.find_by(:id => session[:child_id])
    @chore = Chore.find_by_id(params[:id])
    @chore.child_id = @child.id
    @chore.tagged_complete = 1.to_int
    @chore.save
    
    redirect "/children/#{@child.id}"
  end

  get "/chores/:id/done1" do
    @child = Child.find_by(:id => session[:child_id])
    @chore = Chore.find_by_id(params[:id])
    @chore.tagged_complete = 2.to_int
    @chore.save
    
    redirect "/children/#{@child.id}"
  end

  get "/chores/:id/done2" do
    @parent = Parent.find_by(:id => session[:parent_id])
    @chore = Chore.find_by_id(params[:id])
    @child = Child.find_by(:id => @chore.child_id)
    @chore.tagged_complete = 4.to_int
    @child.balance += @chore.value
    @chore.save
    @child.save
    redirect "/parents/#{@parent.id}"
  end

  get "/chores/:id/done3" do
    @parent = Parent.find_by(:id => session[:parent_id])
    @chore = Chore.find_by_id(params[:id])
    @child = Child.find_by(:id => @chore.child_id)
    @chore.tagged_complete = 4.to_int
    @child.balance += @chore.value
    @chore.save
    @child.save
    
    redirect "/parents/#{@parent.id}"
  end


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
    @chore = Chore.find_by_id(params[:id])
    @parent = Parent.find_by(:id =>session[:parent_id])
    erb :"/chores/edit"
  end

  # PATCH: /chores/5
  patch "/chores/:id" do
    chore = Chore.find_by_id(params[:id])
    @parent = Parent.find_by(:id =>session[:parent_id])
    chore.update(params[:chore])
    flash[:message] = "Chore has been updated."
    redirect :"/parents/#{@parent.id}"
  end

  get '/chores/:id/delete' do
    @parent = Parent.find_by(:id =>session[:parent_id])
    @chore = Chore.find(params[:id])
    erb :"/chores/delete"
  end
  
  # DELETE: /chores/5/delete
  delete "/chores/:id" do
    @parent = Parent.find_by(:id =>session[:parent_id])
    chore = Chore.find_by_id(params[:id])
    chore.destroy
    flash[:message] = "Chore has been removed from the list."
    redirect "/parents/#{@parent.id}"
  end
end
