require "test_helper"

class CaptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @caption = captions(:one)
  end

  test "should get index" do
    get captions_url, as: :json
    assert_response :success
  end

  test "should create caption" do
    assert_difference("Caption.count") do
      post captions_url, params: { caption: { caption_url: @caption.caption_url, text: @caption.text, url: @caption.url } }, as: :json
    end

    assert_response 303
  end

  test "should show caption" do
    get caption_url(@caption), as: :json
    assert_response :success
  end

  test "should update caption" do
    patch caption_url(@caption), params: { caption: { caption_url: @caption.caption_url, text: @caption.text, url: @caption.url } }, as: :json
    assert_response :success
  end

  test "should destroy caption" do
    assert_difference("Caption.count", -1) do
      delete caption_url(@caption), as: :json
    end

    assert_response :no_content
  end
end
