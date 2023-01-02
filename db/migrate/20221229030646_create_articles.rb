class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles, comment: '文章' do |t|
      t.string :title, comment: '标题'
      t.string :content, comment: '正文'

      t.timestamps
    end
  end
end
