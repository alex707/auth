module Users
  class DeleteService
    prepend BasicService

    option :user do
      option :id
    end

    attr_reader :user

    def call
      @user = ::User.with_pk(@user.id)

      if @user.present?
        @user.destroy
      end
    end
  end
end
