require_relative 'config/environment'

map '/users' do
  run UserRoutes
end
