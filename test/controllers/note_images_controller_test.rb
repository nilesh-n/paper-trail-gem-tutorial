require 'test_helper'

class NoteImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @note_image = note_images(:one)
  end

  test "should get index" do
    get note_images_url
    assert_response :success
  end

  test "should get new" do
    get new_note_image_url
    assert_response :success
  end

  test "should create note_image" do
    assert_difference('NoteImage.count') do
      post note_images_url, params: { note_image: { note_id: @note_image.note_id } }
    end

    assert_redirected_to note_image_url(NoteImage.last)
  end

  test "should show note_image" do
    get note_image_url(@note_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_note_image_url(@note_image)
    assert_response :success
  end

  test "should update note_image" do
    patch note_image_url(@note_image), params: { note_image: { note_id: @note_image.note_id } }
    assert_redirected_to note_image_url(@note_image)
  end

  test "should destroy note_image" do
    assert_difference('NoteImage.count', -1) do
      delete note_image_url(@note_image)
    end

    assert_redirected_to note_images_url
  end
end
