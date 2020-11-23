require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  require 'sinatra/base'
  require 'rack-flash'

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    use Rack::Flash
    set :session_secret, "parents_rule_kids_drool"
  end

  get "/" do
    #create session, route to main page
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

    def creating_user
    #returns instance of parent that is signed in, doesn't allow child accounts to access edit/delete pages
      @creating_user||= Parent.find_by(id: session[:parent_id])
    end
      
    

    #defines tagged_complete numerical values for use throughout application
    def tags
      if tagged_complete == 1
        return "not complete"
      elsif tagged_complete == 2
        return "chore complete by child. pending your approval."
      elsif tagged_complete == 3
        return "approved.  pending payment."
      end
      
    end
    
        
  end


  
end
