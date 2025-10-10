require "test_helper"

class ChallengeParticipationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get challenge_participations_index_url
    assert_response :success
  end

  test "should get show" do
    get challenge_participations_show_url
    assert_response :success
  end
end
