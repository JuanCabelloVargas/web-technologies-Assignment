require "test_helper"

class ChallengeInvitesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get challenge_invites_index_url
    assert_response :success
  end

  test "should get show" do
    get challenge_invites_show_url
    assert_response :success
  end
end
