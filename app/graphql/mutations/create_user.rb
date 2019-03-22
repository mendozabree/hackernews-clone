module Mutations
  class CreateUser < BaseMutation

    class AuthProviderSignupDta < Types::BaseInputObject
      argument :email, Types::AuthProviderEmailInput, required: false
    end

    argument :name, String, required: true
    argument :auth_provider, AuthProviderSignupDta, required: false

    type Types::UserType

    def resolve(name: nil, auth_provider: nil)
      User.create!(
        name: name,
        email: auth_provider&.[](:email)&.[](:email),
        password: auth_provider&.[](:email)&.[](:password)
      )
    end
  end
end