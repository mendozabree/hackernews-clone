require 'test_helper'

class Mutations::SignInUserTest < ActiveSupport::TestCase
  def perform(args = {})
    Mutations::SignInUser.new(object: nil, context: { session: {} }).resolve(args)
  end

  def create_user
    User.create!(
      name: 'test',
      email: 'test@u.i',
      password: 'there'
    )
  end

  test 'success' do
    user = create_user

    result = perform(
      email: {
        email: user.email,
        password: user.password
      }
    )

    assert result[:token].present?
    assert_equal result[:user], user
  end

  test 'failure because no credentials' do
    assert_nil perform
  end

  test 'failure due to wrong email' do
    create_user
    assert_nil perform(email: { email: 'wong' })
  end

  test 'failure due to wrong password' do
    user = create_user
    assert_nil perform(email: { email: user.email, password: 'wong' })
  end
end
