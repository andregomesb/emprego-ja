require "rails_helper"

RSpec.describe Job, :type => :model do
  it 'should be valid' do
    cant_blank = "não pode ficar em branco"
    must_exist = "é obrigatório(a)"
    job = Job.create()
    expect(job).not_to be_valid
    expect(job.errors[:title]).to include(cant_blank)
    expect(job.errors[:location]).to include(cant_blank)
    expect(job.errors[:description]).to include(cant_blank)
    expect(job.errors[:category]).to include(must_exist)
    expect(job.errors[:company]).to include(must_exist)
  end

  describe "#expired?" do

    before do
      @company = Company.create(name: 'Campus Code',
                               location: 'São Paulo',
                               phone: '11 2369 3476',
                               mail: 'contato@campuscode.com.br')

      @category = Category.create(name: 'Desenvolvedor')
    end

    context "created today" do
      it "is not expired" do
        job = @company.jobs.create(title: 'Desenvolvedor Rails',
                           description: 'Desenvolvedor Full Stack Rails',
                           location: 'São Paulo - SP',
                           category: @category)
        expect(job).not_to be_expired
      end
    end

    context "created 89 days ago" do
      it "is not expired" do
        travel_to 89.days.ago do
          @job = @company.jobs.create(title: 'Desenvolvedor Rails',
                           description: 'Desenvolvedor Full Stack Rails',
                           location: 'São Paulo - SP',
                           category: @category)
        end
        expect(@job).not_to be_expired
      end
    end

    context "created 90 days ago" do
      it "is expired" do
        travel_to 90.days.ago do
          @job = @company.jobs.create(title: 'Desenvolvedor Rails',
                           description: 'Desenvolvedor Full Stack Rails',
                           location: 'São Paulo - SP',
                           category: @category)
        end
        expect(@job).to be_expired
      end
    end

    context "created 91 days ago" do
      it "is expired" do
        travel_to 91.days.ago do
          @job = @company.jobs.create(title: 'Desenvolvedor Rails',
                           description: 'Desenvolvedor Full Stack Rails',
                           location: 'São Paulo - SP',
                           category: @category)
        end
        expect(@job).to be_expired
      end
    end
  end

  describe "#new?" do
    before do
      @company = Company.create(name: 'Campus Code',
                               location: 'São Paulo',
                               phone: '11 2369 3476',
                               mail: 'contato@campuscode.com.br')

      @category = Category.create(name: 'Desenvolvedor')
    end

    context "created today" do
      it "is new" do
        job = @company.jobs.create(title: 'Desenvolvedor Rails',
                           description: 'Desenvolvedor Full Stack Rails',
                           location: 'São Paulo - SP',
                           category: @category)
        expect(job).to be_new
      end
    end

    context "created 4 days ago" do
      it "is new" do
        travel_to 4.days.ago do
          @job = @company.jobs.create(title: 'Desenvolvedor Rails',
                           description: 'Desenvolvedor Full Stack Rails',
                           location: 'São Paulo - SP',
                           category: @category)
        end
        expect(@job).to be_new
      end
    end

    context "created 6 days ago" do
      it "is not new" do
        travel_to 6.days.ago do
          @job = @company.jobs.create(title: 'Desenvolvedor Rails',
                           description: 'Desenvolvedor Full Stack Rails',
                           location: 'São Paulo - SP',
                           category: @category)
        end
        expect(@job).not_to be_new
      end
    end

    context "created 5 days ago" do
      it "is not new" do
        travel_to 5.days.ago do
          @job = @company.jobs.create(title: 'Desenvolvedor Rails',
                           description: 'Desenvolvedor Full Stack Rails',
                           location: 'São Paulo - SP',
                           category: @category)
        end
        expect(@job).not_to be_new
      end
    end
  end
end
