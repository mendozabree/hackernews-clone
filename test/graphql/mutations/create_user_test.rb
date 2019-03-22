require 'test_helper'

class Mutations::CreateUserTest < ActiveSupport::TestCase
  def perform (user: nil, **args)
    Mutations::CreateUser.new(object:nil, context: {}).resolve(args)
  end

  test 'create a new user' do
    user = perform(
      name: 'test',
      auth_provider: {
        email: {
          email: 'test@u.i',
          password: 'the'
        }
      }
    )
    assert user.persisted?
    assert_equal user.name, 'test'
    assert_equal user.email, 'test@u.i'
  end
end
