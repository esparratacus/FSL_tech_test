# frozen_string_literal: true

require 'rails_helper'


RSpec.describe UrlsController, type: :controller do

  let(:valid_params) { { url: {original_url: "https://google.com"} } }
  let(:url_class) { class_double('Url') }

  let!(:url_list) { FactoryBot.create_list(:url, 20) }
  let!(:url) { FactoryBot.create(:url) }

  describe 'GET #index' do
    it 'shows the latest 10 URLs' do
      get :index
      expect(@controller.instance_variable_get(:@urls)).to be_instance_of(Array)
      expect(@controller.instance_variable_get(:@urls).size).to equal(10)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    it 'creates a new Url' do
      post :create, params: valid_params
      expect(response).to have_http_status(:created)
    end
  end

  describe 'GET #show' do
    it 'shows stats about the given URL' do
      get :show, params:{ url: url.short_url}
      expect(@controller.instance_variable_get(:@url)).to be_instance_of(Url)
      expect(@controller.instance_variable_get(:@url).id).to equal(url.id)
    end

    it 'throws 404 when the URL is not found' do
      get :show, params:{ url: 'a_long_short_and_invalid_url'}
      expect(response).to have_http_status :not_found
    end
  end

  describe 'GET #visit' do
    it 'tracks click event and stores platform and browser information' do
      counter = url.clicks_count
      get :visit, params:{ url: url.short_url}
      expect(@controller.instance_variable_get(:@url).clicks_count).to equal(counter + 1)
      expect(@controller.instance_variable_get(:@url).clicks.count).to be >0
    end

    it 'redirects to the original url' do
      get :visit, params:{ url: url.short_url}
      expect(response).to have_http_status 302
    end

    it 'throws 404 when the URL is not found' do
      get :visit, params:{ url: 'a_long_short_and_invalid_url'}
      expect(response).to have_http_status :not_found
    end
  end
end
