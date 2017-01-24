require 'rails_helper'

feature 'Visitor view premium companies' do
  scenario 'successfully' do
    company = create(:company)

    category = create(:category)

    5.times do
      create(:job, company: company, category: category)
    end

    visit root_path

    click_on company.name

    expect(page).to have_css('h1', text: company.name)
    expect(page).to have_xpath("//img[contains(@src,'estrela')]")
  end
end
