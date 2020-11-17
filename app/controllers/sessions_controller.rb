class SessionsController < ApplicationController
    get '/signup' do 
        @message = session[:message]
        session[:message] = nil
        erb :'sessions/signup'
    end

    post '/signup' do
        @parent = Parent.create(params[:parent])
        if !@parent.save
            session[:message] = "Invalid email or password."
            redirect to '/signup'
        else
            
            session[:message] = "Verify Your Information!"
            binding.pry
            redirect to '/sessions/parent_login'
            
        end
    end

    get '/login' do
        @message = session[:message]
        session[:message] = nil
        erb :'/sessions/login'
    end

    get '/login_route' do
        erb :'/login_route'
    end

    post 'sessions/parents_login' do
        parent = Parent.find_by(email: params[:parent]["email"])
        if parent && parent.authenticate(params[:parent][:password])
            session[:parent_id] = parent.id
            redirect to "/parents/#{current_user.id}"
        else
            @message = "Wrong Email or Password"
            erb :'/parents_login'
        end

    end

    post 'sessions/children_login' do
        child = Child.find_by(email: params[:child]["name"])
        if child && child.authenticate(params[:child][:password])
            session[:child_id] = child.id
            redirect to "/children/#{current_user.id}"
        else
            @message = "Oops, try again!"
            erb :'sessions/children_login'
        end

    end

    get '/logout' do
        session.clear
        redirect to '/'
    end
end