# frozen_string_literal: true

class ArticleEntity < Meta::Entity
  property :id, type: 'integer', description: 'id', param: false
  property :title, type: 'string', description: '标题'
  property :content, type: 'string', description: '正文', scope: 'full'
end
