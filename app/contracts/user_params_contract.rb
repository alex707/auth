class UserParamsContract < Dry::Validation::Contract
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  NAME_FORMAT = /\A\w+\z/

  params do
    required(:user).hash do
      optional(:id)
      required(:name).value(:string)
      required(:email).value(:string)
      required(:password).filled(:string)
      required(:password_confirmation).filled(:string)
    end
  end

  # rule(:email) do
  #   unless EMAIL_FORMAT.match?(value)
  #     key.failure('email has invalid format')
  #   end
  # end
end
