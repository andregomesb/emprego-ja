require "rails_helper"

RSpec.describe Job, :type => :model do
  it 'should be valid' do
    cant_blank = "não pode ficar em branco"
    job = Job.create()
    expect(job).not_to be_valid
    expect(job.errors[:title]).to include(cant_blank)
    expect(job.errors[:location]).to include(cant_blank)
    expect(job.errors[:description]).to include(cant_blank)
    expect(job.errors[:category]).to include(cant_blank)
  end
end
