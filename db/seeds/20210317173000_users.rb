Sequel.seed(:development, :test) do
  def run
    ::User.create \
      name: "richard_feynman",
      email: "richard@feynman.com",
      password: "271828",
      password_confirmation: "271828"

    ::User.create \
      name: "stephen_hawking",
      email: "stephen@hawking.com",
      password: "271828",
      password_confirmation: "271828"
  end
end
