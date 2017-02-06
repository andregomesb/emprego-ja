require 'rails_helper'

RSpec.describe 'Jobs API', type: :request do
  let(:company) {create(:company)}
  let(:category) {create(:category)}

  let!(:jobs) do
    create_list(:jobs, 20, category: category, company: company)
  end

  let(:job_id) {jobs.first.id}

  describe "GET /jobs" do
    before {get '/api/v1/jobs'}

    it 'returns jobs' do
      expect(json).not_to be_empty
      expect(json.size).to eq(20)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /jobs/:id' do
    before { get "/api/v1/jobs/#{job_id}" }

    context 'when the record exists' do
      it 'returns the job' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(job_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:job_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find job/i)
      end
    end
  end

  describe 'POST /jobs' do
    let(:job_params) { {job:{
                  title: 'Rails Dev',
                  location: 'Rio de Janeiro',
                  description:'This is a description',
                  company_id: company.id,
                  category_id: category.id,
                  featured: false
              } } }

    context 'when the request is valid' do

      before { post '/api/v1/jobs', params: job_params }

      it 'creates a Job' do
        expect(json['title']).to eq('Rails Dev')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/jobs', params: {job:{ title: 'Foobar' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/não pode ficar em branco/i)
      end
    end
  end

  describe 'PUT /jobs/:id' do

    context 'when the record exists' do
      let(:job_params) { { job: { title: 'Senior Dev' } } }
      before { put "/api/v1/jobs/#{job_id}", params: job_params}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'verify modification' do
        get "/api/v1/jobs/#{job_id}", params: job_params
        expect(json['id']).to eq(job_id)
        expect(json).not_to be_empty
        expect(json['title']).to match(/Senior Dev/)
      end
    end

    context 'when the request is invalid' do
      let(:job_params) { { job: { title: '' } } }
      before { put "/api/v1/jobs/#{job_id}", params: job_params}
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/não pode ficar em branco/i)
      end
    end
  end

  describe 'DELETE /jobs/:id' do
    before { delete "/api/v1/jobs/#{job_id}" }
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end


