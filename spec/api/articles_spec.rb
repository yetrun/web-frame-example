# frozen_string_literal: true

require_relative '../spec_helper'

describe 'API::Articles' do
  include AppSpec

  before do
    @article = create(:article)
  end

  it '查看文章列表' do
    get '/articles'

    expect(last_response).to has_status(200)
    expect(JSON.parse(last_response.body)['articles'].length).to eq(1)
  end

  it '查看文章详情' do
    get "/articles/#{@article.id}"

    expect(last_response).to has_status(200)
    expect(JSON.parse(last_response.body)['article']['id']).to eq(@article.id)
  end

  it '创建文章' do
    expect {
      post "/articles",
           { article: attributes_for(:article, title: '新文章')}.to_json,
           { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to has_status(201)
      expect(JSON.parse(last_response.body)['article']['title']).to eq('新文章')
    }.to change { Article.count }.by(1)
  end

  it '更新文章' do
    patch "/articles/#{@article.id}",
          { article: { title: '更新标题' }}.to_json,
          { 'CONTENT_TYPE' => 'application/json' }

    expect(last_response).to has_status(200)
    expect(JSON.parse(last_response.body)['article']['title']).to eq('更新标题')
  end

  it '删除文章' do
    expect {
      delete "/articles/#{@article.id}"

      expect(last_response).to has_status(204)
    }.to change { Article.count }.by(-1)
  end
end
