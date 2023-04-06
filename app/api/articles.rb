# frozen_string_literal: true

module API
  class Articles < Meta::Application
    get '/articles' do
      title '获取文章列表'
      status 200 do
        expose :articles, type: 'array', ref: ArticleEntity
      end
      action do
        articles = Article.all
        render :articles, articles
      end
    end

    post '/articles' do
      title '新建文章'
      params do
        param :article, required: true, ref: ArticleEntity.lock_scope('full')
      end
      status 201 do
        expose :article, ref: ArticleEntity.lock_scope('full')
      end
      action do
        article = Article.create!(params[:article])
        render :article, article
        response.status = 201
      end
    end

    get '/articles/:id' do
      title '获取文章详情'
      parameters do
        param :id, type: 'integer', in: 'path', description: '文章实体的 id'
      end
      status 200 do
        expose :article, required: true, ref: ArticleEntity.lock_scope('full')
      end
      action do
        article = Article.find(params[:id])
        render :article, article
      end
    end

    patch '/articles/:id' do
      title '更新文章'
      parameters do
        param :id, type: 'integer', in: 'path', description: '文章实体的 id'
      end
      request_body do
        property :article, required: true, ref: ArticleEntity.locked(scope: 'full', discard_missing: true)
      end
      status 200 do
        property :article, ref: ArticleEntity.lock_scope('full')
      end
      action do
        article = Article.find(params[:id])
        article.update!(params[:article])
        render :article, article
      end
    end

    delete '/articles/:id' do
      title '删除文章'
      parameters do
        param :id, type: 'integer', in: 'path', description: '文章实体的 id'
      end
      action do
        article = Article.find(params[:id])
        article.destroy!
        response.status = 204
      end
    end
  end
end
