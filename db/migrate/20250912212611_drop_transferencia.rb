class DropTransferencia < ActiveRecord::Migration[8.0]
  def change
    drop_table :transferencia
  end
end