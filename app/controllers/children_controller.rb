require 'sinatra/base'
require 'rack-flash'

class ChildrenController < ApplicationController

  # GET: /children/new
  get "/children/new" do
    if logged_in? && current_user #verifys user logged in and correct user (using helpers)
      @parent = Parent.find_by(:id =>session[:parent_id])
      erb :"/children/new"
    else
      #reroute to login page and error message if not verified
      flash[:message] = "Please log in." 
      redirect "/login_route"
    end
  end

  # POST: /children
  post "/children/new" do
    #create child account and attach to creating parent account
    @parent = Parent.find_by(:id =>session[:parent_id])
    @child = Child.create(params[:child])
    redirect "/parents/#{@parent.id}"
  end

  get "/children/:id/pay" do
    if logged_in? && creating_user #verifys user logged in and correct user (using helpers)
      #finds correct child account, zeros out balance and returns to parent page
      @parent = Parent.find_by(:id =>session[:parent_id])
      child = Child.find_by_id(params[:id])
      child.balance = 0
      child.save
      redirect "/parents/#{@parent.id}"
    else
      #reroute to login page and error message if not verified
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  # GET: /children/5/edit
  get "/children/:id/edit" do
    if logged_in? && creating_user #verifys user logged in and correct user (using helpers)
      @child = Child.find_by_id(params[:id])
      @parent = Parent.find_by(:id =>session[:parent_id])
      erb :"/children/edit"
    else
      #reroute to login page and error message if not verified
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  get "/children/:id" do
    if logged_in? && current_user #verifys user logged in and correct user (using helpers)
      #find child and all corresponding chores(multiple categories)
      @child = Child.find_by_id(session[:child_id])
      @chores = Chore.where(:child_id => session[:child_id])
      @current_chores = @chores.where(:tagged_complete => 1)
      @done_chores = @chores.where(:tagged_complete => 2)
      @payme_chores = @chores.where(:tagged_complete => 3)
      @available_chores = Chore.where(:parent_id => @child.parent_id)
      @available_chores = @available_chores.where(:child_id => nil)
      erb :"/children/show"
    else
      #reroute to login page and error if not verified
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end

  # PATCH: /children/5
  patch "/children/:id" do
    #update all child information from edit form, reroute to parent page, give confirmation message
    @parent = Parent.find_by(:id =>session[:parent_id])
    child = Child.find_by_id(params[:id])
    child.update(params[:child])
    flash[:message] = "Child successfully updated."
    redirect "/parents/#{@parent.id}"
  end

  get '/children/:id/delete' do
    if logged_in? && creating_user #verifys user logged in and correct user (using helpers)
      @parent = Parent.find_by(:id =>session[:parent_id])
      @child = Child.find(params[:id])
      erb :"/children/delete"
    else
      #reroute to login page and error if not verified
      flash[:message] = "Please log in."
      redirect "/login_route"
    end
  end
  # DELETE: /children/5/delete
  delete "/children/:id" do
    #destroy child, route back to parent page and confirmation message
    @parent = Parent.find_by(:id =>session[:parent_id])
    child = Child.find_by_id(params[:id])
    child.destroy
    flash[:message] = "Child successfully left the nest."
    redirect "/parents/#{@parent.id}"
  end
end
