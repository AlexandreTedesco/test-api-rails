class CreateJwtDenylists < ActiveRecord::Migration[8.0]
  def change
    create_table :jwt_denylists do |t|
      t.belongs_to :user, index: true
      t.string :jti, index: true
      t.datetime :created_at
    end
  end
end
