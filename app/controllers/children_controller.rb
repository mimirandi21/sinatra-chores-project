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
    
    redirect "/parents/#{@parent.id}"
  end

  get "/children/:id/pay" do
    @parent = Parent.find_by(:id =>session[:parent_id])
    child = Child.find_by_id(params[:id])
    child.balance = 0
    child.save
    redirect "/parents/#{@parent.id}"
  end

  # GET: /children/5/edit
  get "/children/:id/edit" do
    @child = Child.find_by_id(params[:id])
    @parent = Parent.find_by(:id =>session[:parent_id])
    erb :"/children/edit"
  end

  get "/children/:id" do
    @child = Child.find_by_id(session[:child_id])
    @chores = Chore.where(:child_id => session[:child_id])
    @current_chores = @chores.where(:tagged_complete => 1)
    @done_chores = @chores.where(:tagged_complete => 2)
    @payme_chores = @chores.where(:tagged_complete => 3)
    @available_chores = Chore.where(:parent_id => @child.parent_id)
    @available_chores = @available_chores.where(:child_id => nil)
    
    erb :"/children/show"
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
