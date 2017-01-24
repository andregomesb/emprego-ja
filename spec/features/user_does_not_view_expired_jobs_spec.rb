require 'rails_helper'

feature 'Visitor does not see expired jobs' do
  scenario 'successfully' do

    travel_to 91.days.ago do
      create(:job)
    end

    visit root_path

    expect(page).not_to have_content('Desenvolvedor Rails')
  end

  scenario 'visit expired job page' do
    travel_to 91.days.ago do
      @job = create(:job)
    end

    visit job_path(@job)

    expect(page).to have_content('Vaga Expirada')
  end
end
