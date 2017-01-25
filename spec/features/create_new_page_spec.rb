require 'rails_helper'

feature "Page" do

  scenario "Create a new page" do
    visit pages_path

    click_link "Nieuwe pagina"

    fill_in "Naam", with: "Nieuwe pagina"
    fill_in "Aantal regels", with: "20"

    click_button "Create Page"

    expect(page).to have_content "Pagina aangemaakt"
  end

end
