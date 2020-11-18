class SessionsController < ApplicationController
    get '/signup' do 
        @message = session[:message]
        session[:message] = nil
        erb :'/sessions/signup'
    end

    post '/signup' do
        @parent = Parent.new(params[:parent])
        if has_account
            session[:message] = "Oops, looks like you already have an account."
            redirect to '/login'
        elsif !@parent.save
            session[:message] = "Hmmm... there must have been a typo.  Please try again."
            redirect to '/signup'
            
        else
            
            @parent.save
            session[:message] = "Verify Your Information!"
            redirect to '/parents_login'
        end
    end

    get '/parents_login' do
        
        @message = session[:message]
        session[:message] = nil
        erb :'/sessions/parents_login'
    end

    get '/children_login' do
        @message = session[:message]
        session[:message] = nil
        erb :'/sessions/children_login'
    end

    get '/login_route' do
        erb :'/login_route'
    end

    post '/parents_login' do
        @parent = Parent.find_by(email: params[:parent][:email])

        if @parent && @parent.authenticate(params[:parent][:password])
            session[:parent_id] = @parent.id
            redirect to "/parents/#{current_user.id}"
        else
            @message = "Wrong Email or Password"
            erb :'/sessions/parents_login'
        end

    end

    post '/children_login' do
        child = Child.find_by(email: params[:child]["name"])
        if child && child.authenticate(params[:child][:password])
            session[:child_id] = child.id
            redirect to "/children/#{current_user.id}"
        else
            @message = "Oops, try again!"
            erb :'/children_login'
        end

    end

    get '/logout' do
        session.clear
        redirect to '/'
    end
end