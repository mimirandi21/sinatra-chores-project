
require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

use Rack::MethodOverride
  # ^^ Middleware for put/patch/delete requests (looking for key of "_method" and then follows the direct of the value)
  use ChoresController
  use ChildrenController
  use ParentsController
  use SessionsController
  run ApplicationController

