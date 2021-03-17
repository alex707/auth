module Users
  class UpdateService
    prepend BasicService

    option :user do
      option :id
      option :name
      option :email
      option :password
      option :password_confirmation
    end

    attr_reader :user

    def call
      user_params = @user.to_h.transform_keys(&:to_sym)
      @user = ::User.find(id: user_params.delete(:id))
      @user.set(user_params)

      if @user.valid?
        @user.save
      else
        fail!(@user.errors)
      end
    end
  end
end
