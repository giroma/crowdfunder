class CreateOwnerUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :owner_updates do |t|
      t.text :project_update
      t.references :project, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
