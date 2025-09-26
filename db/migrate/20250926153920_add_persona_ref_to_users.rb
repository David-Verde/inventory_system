class AddPersonaRefToUsers < ActiveRecord::Migration[8.0]
  def change
    add_reference :users, :persona, null: true, foreign_key: true
  end
end