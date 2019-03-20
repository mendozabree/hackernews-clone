require 'test_helper'

class Mutations::CreateLinksTest < ActiveSupport::TestCase
  def perform (user: nil, **args)
    Mutations::CreateLink.new(object:nil, context: {}).resolve(args)
  end

  test 'create a new link' do
    link = perform(
      url: 'http://test.com',
      description: 'test url'
    )
    assert link.persisted?
    assert_equal link.description, 'test url'
    assert_equal link.url, 'http://test.com'
  end
end
