class CreateClaims < ActiveRecord::Migration[5.1]
  def change
    create_table :claims do |t|
      t.references :project, foreign_key: true
      t.references :reward, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
