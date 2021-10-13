class CreateSearchResults < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'btree_gin'

    create_table :search_results do |t|
      t.belongs_to :search_phrase
      t.text :products, null: false, array: true, default: []

      t.timestamps
    end

    add_index :search_results, :products, using: :gin
  end
end