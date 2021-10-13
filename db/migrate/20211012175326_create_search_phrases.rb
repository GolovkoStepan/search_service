class CreateSearchPhrases < ActiveRecord::Migration[6.1]
  def change
    create_table :search_phrases do |t|
      t.string :text, null: false

      t.timestamps
    end
  end
end
