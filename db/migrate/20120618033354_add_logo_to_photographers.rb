class AddLogoToPhotographers < ActiveRecord::Migration
  def change
    add_column :photographers, :logo_uid, :string
  end
end
