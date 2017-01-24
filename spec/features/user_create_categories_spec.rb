require 'rails_helper'

feature "User create category" do
  scenario "successfully" do
    category = create(:category)

    visit new_category_path

    fill_in "Categoria", with: category
    click_on "Criar Categoria"

    expect(page).to have_css('h1', text: category)
  end

  scenario "and should fill the fields" do
    visit new_category_path

    click_on "Criar Categoria"

    expect(page).to have_content 'Não foi possível criar categoria'
  end

  scenario "and is unique" do
    category = create(:category)

    visit new_category_path

    fill_in "Categoria", with: category.name
    click_on "Criar Categoria"

    expect(page).to have_content 'Não foi possível criar categoria'
  end

  scenario "and validates case sensitive" do
    category = create(:category)

    visit new_category_path

    fill_in "Categoria", with: category.name.upcase
    click_on "Criar Categoria"

    expect(page).to have_content 'Não foi possível criar categoria'
  end
end
