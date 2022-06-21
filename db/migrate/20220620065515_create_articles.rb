class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles, id: :uuid do |t|
      t.string :title
      t.string :outline
      t.text :content
      t.references :category, null: false, foreign_key: true, type: :uuid
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.datetime :published_at
      t.boolean :is_shown, default: true
      t.string :slug
      t.string :tags
      t.timestamps
    end
  end
end
