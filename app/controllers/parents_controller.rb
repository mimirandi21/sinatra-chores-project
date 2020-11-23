require 'sinatra/base'
require 'rack-flash'

class ParentsController < ApplicationController


  # GET: /parents/5
  get "/parents/:id" do
    if logged_in? && creating_user #verifys user logged in and correct user (using helpers)
      #find parent, all created children and all created chores(separated into multiple categories)
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
      #reroute to login page and error message if not verified
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  # GET: /parents/5/edit
  get "/parents/:id/edit" do
    if logged_in? && creating_user #verifys user logged in and correct user (using helpers)
      @parent = Parent.find_by_id(params[:id])
      erb :"/parents/edit"
    else
      #reroute to login page and error message if not verified
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  # PATCH: /parents/5
  patch "/parents/:id" do
    #update parent account, back to parent page and confirmation message
    if logged_in? && creating_user #verifys user logged in and correct user (using helpers)
      @parent = Parent.find_by_id(params[:id])
      @parent.update(params[:parent])
      flash[:message] = "Your account has been updated."
      redirect :"/parents/#{@parent.id}"
    else
      #reroute to login page and error message if not verified
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  get '/parents/:id/delete' do
    if logged_in? && creating_user #verifys user logged in and correct user (using helpers)
      @parent = Parent.find(params[:id])
      erb :"/parents/delete"
    else
      #reroute to login page and error message if not verified
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end
  # DELETE: /parents/5/delete
  delete "/parents/:id" do
    #delete parent account and all created children/chores, clear session, return to main page
    if logged_in? && creating_user #verifys user logged in and correct user (using helpers)
      parent = Parent.find_by_id(params[:id])
      children = Child.where(:parent_id => params[:id])
      chores = Child.where(:parent_id => params[:id])
      children.destroy_all
      chores.destroy_all
      parent.destroy
      session.clear
      redirect "/"
    else
      #reroute to login page and error message if not verified
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  
end
