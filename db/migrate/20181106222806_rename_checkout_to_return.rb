class RenameCheckoutToReturn < ActiveRecord::Migration[5.2]
  def change
    rename_column :rentals, :checkout_date, :return_date
  end
end
