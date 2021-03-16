class UserRoutes < Application
  helpers PaginationLinks

  namespace '/v1' do
  	get do
  		page = params[:page].presence || 1
  		users = User.reverse_order(:updated_at)
  		users = users.paginate(page.to_i, Settings.pagination.page_size)
  		serializer = UserSerializer.new(users.all,
        links: pagination_links(users))

  		json serializer.serializable_hash
  	end

  	post do
  		user_params = validate_with!(UserParamsContract)

  		result = Users::CreateService.call(
  			user: user_params[:user]
  		)

  		if result.success?
  			serializer = UserSerializer.new(result.user)

  			status 201
  			json serializer.serializable_hash
  		else
  			status 422
  			error_response result.user
  		end
  	end
  end
end
