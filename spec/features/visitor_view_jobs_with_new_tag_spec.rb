require 'rails_helper'

feature "Visitor view jobs with new tag" do
  scenario "successfully" do
    company = create(:company)

    category = create(:category)

    5.times do
      create(:job, company: company, category: category)
    end

    visit root_path

    expect(page).to have_content 'Novidade'
    expect(page).to have_css('.badge', text:'Novidade' )
  end

  scenario "no badge for old jobs" do
    create(:job, created_at: 5.days.ago)

    visit root_path
    expect(page).not_to have_content 'Novidade'
    expect(page).not_to have_css('.badge', text:'Novidade' )
  end

  scenario "badge in details" do
    job = create(:job)
    visit job_path(job)
    expect(page).to have_content 'Novidade'
    expect(page).to have_css('.badge', text:'Novidade' )
  end
end
