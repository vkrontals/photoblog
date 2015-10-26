class AddTables < ActiveRecord::Migration
  def change

    create_table :users do |t|

      t.string :password_digest
      t.string :email
      t.string :url
      t.string :display_name

      t.timestamps null: false
    end

    create_table :images do |t|

      t.string :url
      t.datetime :uploaded_time
      t.string :alt_txt
      t.string :caption
      t.integer :post_id

      t.timestamps null: false
    end

    create_table :posts do |t|

      t.integer :author_id
      t.text :content
      t.datetime :publish_date
      t.string :title
      t.text :excerpt
      t.string :permalink
      t.string :status
      t.integer :comment_count

      t.timestamps null: false
    end

    create_table :terms do |t|

      t.string :name
      t.string :slug
      t.string :term_group

      t.timestamps null: false
    end

    create_table :posts_terms do |t|

      t.integer :post_id
      t.integer :term_id

      t.timestamps null: false
    end

    add_index :images, :post_id
    add_index :posts, :author_id
    add_index :posts_terms, [:post_id, :term_id]
    add_index :terms, :term_group

    # TODO: add index to posts permalink
  end
end

