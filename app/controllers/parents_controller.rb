require 'sinatra/base'
require 'rack-flash'

class ParentsController < ApplicationController


  # GET: /parents/5
  get "/parents/:id" do
    if logged_in? && creating_user
      @chores = Chore.where(:parent_id => session[:parent_id])
      @current_chores = @chores.where(:tagged_complete => 0)
      @taken_chores = @chores.where(:tagged_complete => 1)
      @approve_chores = @chores.where(:tagged_complete => 2)
      @done_chores = @chores.where(:tagged_complete => 4)
      @payme_chores = @chores.where(:tagged_complete => 3)
      @children = Child.where(:parent_id => session[:parent_id])
      @parent = Parent.find_by_id(session[:parent_id])
      erb :"/parents/show"
    else
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  # GET: /parents/5/edit
  get "/parents/:id/edit" do
    if logged_in? && creating_user
      @parent = Parent.find_by_id(params[:id])
      erb :"/parents/edit"
    else
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  # PATCH: /parents/5
  patch "/parents/:id" do
    @parent = Parent.find_by_id(params[:id])
    @parent.update(params[:parent])
    flash[:message] = "Your account has been updated."
    redirect :"/parents/#{@parent.id}"
  end

  get '/parents/:id/delete' do
    if logged_in? && creating_user
      @parent = Parent.find(params[:id])
      erb :"/parents/delete"
    else
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end
  # DELETE: /parents/5/delete
  delete "/parents/:id" do
    parent = Parent.find_by_id(params[:id])
    children = Child.where(:parent_id => params[:id])
    chores = Child.where(:parent_id => params[:id])
    children.destroy_all
    chores.destroy_all
    parent.destroy
    session.clear
    redirect "/"
  end

  
end
