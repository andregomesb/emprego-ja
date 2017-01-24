require 'rails_helper'

feature 'User create companies' do
  scenario 'successfully' do
    company = build(:company)

    visit new_company_path

    fill_in 'Nome',      with: company.name
    fill_in 'Local',     with: company.location
    fill_in 'Email',     with: company.mail
    fill_in 'Telefone',  with: company.phone

    click_on 'Criar Empresa'

    expect(page).to have_css('h1', text: company.name)
    expect(page).to have_content(company.location)
    expect(page).to have_content(company.mail)
    expect(page).to have_content(company.phone)
  end

  scenario 'is unique' do
    company = create(:company)

    visit new_company_path

    fill_in 'Nome',      with: company.name
    fill_in 'Local',     with: company.location
    fill_in 'Email',     with: company.mail
    fill_in 'Telefone',  with: company.phone

    click_on 'Criar Empresa'

    expect(page).to have_content("Não foi possível criar empresa")
    expect(page).to have_content("Nome já está em uso")
  end

  scenario 'and should fill all fields' do
    visit new_company_path

    click_on 'Criar Empresa'

    expect(page).to have_content 'Não foi possível criar empresa'
  end
end
