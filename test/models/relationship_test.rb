require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:jerome).id,
                                     followed_id: users(:kevin).id)
  end

  test "should be valid" do
    assert @relationship.valid?

  end

  test 'follower_id must exist' do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test 'followed_id must exist' do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
