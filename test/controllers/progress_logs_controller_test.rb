require "test_helper"

class ProgressLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get progress_logs_index_url
    assert_response :success
  end

  test "should get show" do
    get progress_logs_show_url
    assert_response :success
  end
end
