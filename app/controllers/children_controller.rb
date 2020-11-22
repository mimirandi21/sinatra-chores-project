require 'sinatra/base'
require 'rack-flash'

class ChildrenController < ApplicationController

  

  # GET: /children/new
  get "/children/new" do
    if logged_in? && current_user
      @parent = Parent.find_by(:id =>session[:parent_id])
      erb :"/children/new"
    else
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  # POST: /children
  post "/children/new" do
    @parent = Parent.find_by(:id =>session[:parent_id])
    @child = Child.create(params[:child])
    
    redirect "/parents/#{@parent.id}"
  end

  get "/children/:id/pay" do
    if logged_in? && creating_user
      @parent = Parent.find_by(:id =>session[:parent_id])
      child = Child.find_by_id(params[:id])
      child.balance = 0
      child.save
      redirect "/parents/#{@parent.id}"
    else
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  # GET: /children/5/edit
  get "/children/:id/edit" do
    if logged_in? && creating_user
      @child = Child.find_by_id(params[:id])
      @parent = Parent.find_by(:id =>session[:parent_id])
      erb :"/children/edit"
    else
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  get "/children/:id" do
    if logged_in? && current_user
      @child = Child.find_by_id(session[:child_id])
      @chores = Chore.where(:child_id => session[:child_id])
      @current_chores = @chores.where(:tagged_complete => 1)
      @done_chores = @chores.where(:tagged_complete => 2)
      @payme_chores = @chores.where(:tagged_complete => 3)
      @available_chores = Chore.where(:parent_id => @child.parent_id)
      @available_chores = @available_chores.where(:child_id => nil)
    
      erb :"/children/show"
    else
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
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
    if logged_in? && creating_user
      @parent = Parent.find_by(:id =>session[:parent_id])
      @child = Child.find(params[:id])
      erb :"/children/delete"
    else
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
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
