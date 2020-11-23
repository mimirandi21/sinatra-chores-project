require 'sinatra/base'
require 'rack-flash'

class SessionsController < ApplicationController
    get '/signup' do 
        if logged_in? #verifys user logged in (using helpers)
            #error message
            @message = "You are already logged in"
        else
            #create session message (@message), route to signup
            @message = session[:message]
            session[:message] = nil
            erb :'/sessions/signup'
        end
    end

    post '/signup' do
        @parent = Parent.new(params[:parent])
        #if unable to save, error message and send back to signup screen
        if !@parent.save
            session[:message] = "Hmmm... there must have been a typo.  Please try again."
            redirect to '/signup'
        else
            #else save and route to parent login, message to verify   
            @parent.save
            session[:message] = "Verify Your Information!"
            redirect to '/parents_login'
        end
    end

    get '/parents_login' do
        #create session message (@message) and route to parent login
        @message = session[:message]
        session[:message] = nil
        erb :'/sessions/parents_login'
    end

    get '/children_login' do
        #create session message (@message) and route to child login
        @message = session[:message]
        session[:message] = nil
        erb :'/sessions/children_login'
    end

    get '/login_route' do
        #login route
        erb :'/login_route'
    end

    post '/parents_login' do
        @parent = Parent.find_by(email: params[:parent][:email])

        if @parent && @parent.authenticate(params[:parent][:password]) #verify parent and authenticate password
            #assign session parent id to parent id and redirect to parent page
            session[:parent_id] = @parent.id
            redirect to "/parents/#{current_user.id}"
        else
            #redirect to login page and error message if not verified
            @message = "Wrong Email or Password"
            erb :'/sessions/parents_login'
        end

    end

    post '/children_login' do
        child = Child.find_by(name: params[:child][:name])
        
        if child && child.authenticate(params[:child][:password]) #verify child and authenticate password
            #assign session child id to child id and redirect to child page
            session[:child_id] = child.id
            redirect to "/children/#{current_user.id}"
        else
            #redirect to login page and error message if not verified
            @message = "Oops, try again!"
            erb :'sessions/children_login'
        end

    end

    get '/logout' do
        #clear session and route to main page
        session.clear
        redirect to '/'
    end
end