ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'
    #creating rake tasks (rake Rakefile)

desc 'A console'
task :console do
    Pry.start
end
    #creating rake console