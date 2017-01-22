require 'rails_helper'

feature "Visitor view jobs with new tag" do
  scenario "successfully" do
    company = Company.create(name: 'Campus Code',
                              location: 'São Paulo',
                              phone: '11 2369 3476',
                              mail: 'contato@campuscode.com.br')

    category = Category.create(name: 'Desenvolvedor')

    5.times do
      company.jobs.create(title: 'Desenvolvedor Rails',
                           description: 'Desenvolvedor Full Stack Rails',
                           location: 'São Paulo - SP',
                           category: category)
    end

    visit root_path

    expect(page).to have_content 'Novidade'
    expect(page).to have_css('.badge', text:'Novidade' )
  end

  scenario "no badge for old jobs" do
    company = Company.create(name: 'Campus Code',
                              location: 'São Paulo',
                              phone: '11 2369 3476',
                              mail: 'contato@campuscode.com.br')

    category = Category.create(name: 'Desenvolvedor')

    company.jobs.create(title: 'Desenvolvedor Rails',
                         description: 'Desenvolvedor Full Stack Rails',
                         location: 'São Paulo - SP',
                         category: category,
                         created_at: 5.days.ago)

    visit root_path
    expect(page).not_to have_content 'Novidade'
    expect(page).not_to have_css('.badge', text:'Novidade' )
  end

  scenario "badge in details" do
    company = Company.create(name: 'Campus Code',
                              location: 'São Paulo',
                              phone: '11 2369 3476',
                              mail: 'contato@campuscode.com.br')

    category = Category.create(name: 'Desenvolvedor')

    job = company.jobs.create(title: 'Desenvolvedor Rails',
                         description: 'Desenvolvedor Full Stack Rails',
                         location: 'São Paulo - SP',
                         category: category)

    visit job_path(job)
    expect(page).to have_content 'Novidade'
    expect(page).to have_css('.badge', text:'Novidade' )
  end
end
