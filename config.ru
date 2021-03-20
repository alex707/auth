require_relative 'config/environment'

map '/users' do
  run UserRoutes
end

run Rack::URLMap.new(
  '/v1/signup' => UserRoutes,
  '/v1/login' => UserSessionRoutes,
  '/v1/auth' => AuthRoutes
)
