require 'rails_helper'

feature 'User edit company' do
  scenario 'successfully' do
    company = create(:company)

    visit edit_company_path(company)

    fill_in 'Nome', with: 'Locaweb'
    fill_in 'Localização', with: 'Rio de Janeiro'
    click_on 'Atualizar Empresa'

    expect(page).to have_content 'Locaweb'
    expect(page).to have_content 'Rio de Janeiro'
    expect(page).to have_content 'Empresa atualizada com sucesso'
  end

  scenario 'valid data' do
    company = create(:company)
    
    visit edit_company_path(company)

    fill_in 'Nome', with: ''
    click_on 'Atualizar Empresa'

    expect(page).to have_content 'Não foi possível atualizar a empresa'
  end
end
