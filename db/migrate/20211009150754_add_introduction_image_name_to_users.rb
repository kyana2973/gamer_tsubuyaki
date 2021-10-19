class AddIntroductionImageNameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :introduction, :text
    add_column :users, :image_name, :integer
  end
end
