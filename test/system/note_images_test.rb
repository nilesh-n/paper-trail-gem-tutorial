require "application_system_test_case"

class NoteImagesTest < ApplicationSystemTestCase
  setup do
    @note_image = note_images(:one)
  end

  test "visiting the index" do
    visit note_images_url
    assert_selector "h1", text: "Note Images"
  end

  test "creating a Note image" do
    visit note_images_url
    click_on "New Note Image"

    fill_in "Note", with: @note_image.note_id
    click_on "Create Note image"

    assert_text "Note image was successfully created"
    click_on "Back"
  end

  test "updating a Note image" do
    visit note_images_url
    click_on "Edit", match: :first

    fill_in "Note", with: @note_image.note_id
    click_on "Update Note image"

    assert_text "Note image was successfully updated"
    click_on "Back"
  end

  test "destroying a Note image" do
    visit note_images_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Note image was successfully destroyed"
  end
end
