require "test_helper"

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:jerome)
    @other_user = users(:kevin)
    @user_without_micropost = users(:marie)
  end

  test 'micropost interface' do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination', count: 1
    # invalid submission
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: '' } }
    end
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors', count: 1
    assert_select 'a[href=?]', '/?page=2' # correct pagination link
    assert_template 'static_pages/home'
    # valid submission
    content = 'coucou'
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
    # delete a micropost
    assert_select 'a', text: 'delete'
    first_micropost = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_micropost)
    end
    # visit another user's page and not having delete links
    get user_path(@other_user)
    assert_select 'a', text: 'delete', count: 0
  end

  test 'micropost sidebar count' do
    # user with many microposts
    log_in_as(@user)
    get root_path
    assert_match "#{@user.microposts.count} microposts", response.body
    # user with no micropost
    log_in_as(@user_without_micropost)
    get root_path
    assert_match '0 microposts', response.body
    @user_without_micropost.microposts.create!(content: 'first micropost for that user')
    get root_path
    assert_match '1 micropost', response.body
  end
end
