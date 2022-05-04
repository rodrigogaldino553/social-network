require "application_system_test_case"

class PicturesTest < ApplicationSystemTestCase
  setup do
    @picture = pictures(:one)
  end

  test "visiting the index" do
    visit pictures_url
    assert_selector "h1", text: "Pictures"
  end

  test "should create picture" do
    visit pictures_url
    click_on "New picture"

    fill_in "Legend", with: @picture.legend
    click_on "Create Picture"

    assert_text "Picture was successfully created"
    click_on "Back"
  end

  test "should update Picture" do
    visit picture_url(@picture)
    click_on "Edit this picture", match: :first

    fill_in "Legend", with: @picture.legend
    click_on "Update Picture"

    assert_text "Picture was successfully updated"
    click_on "Back"
  end

  test "should destroy Picture" do
    visit picture_url(@picture)
    click_on "Destroy this picture", match: :first

    assert_text "Picture was successfully destroyed"
  end
end
