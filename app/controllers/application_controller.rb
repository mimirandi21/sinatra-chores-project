require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "parents_rule_kids_drool"
  end

  get "/" do
    @message = session[:message]
    session[:message] = nil
    erb :welcome
  end

  helpers do
    # returns true if there is a parent or child id in the session hash 
    def logged_in?
      !!session[:parent_id] || !!session[:child_id]
    end
    # returns the instance of a parent or child that is signed in, assigns them to @current_user
    def current_user
      @current_user ||= Parent.find_by(id: session[:parent_id]) || @current_user ||= Child.find_by(id: session[:child_id])
    end

    def has_account
      if Parent.all.each{|parent| parent.email == @parent.email} == true
        true
      else
        false
      end
      
    end

    #defines tagged_complete numerical values for use throughout application
    def tags
      
    end
    
    # finds all todos that are incomplete and have a datetime prior to current time
    def incomplete_chores(todos)
      Chore.select{ |chore| chore.tagged_complete != 3 }
    end
    
  end


  
end
