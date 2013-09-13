class AddCropInfoToImages < ActiveRecord::Migration
  def change
    add_column :spree_assets, :crop_x, :integer
    add_column :spree_assets, :crop_y, :integer
    add_column :spree_assets, :crop_w, :integer
    add_column :spree_assets, :crop_h, :integer
  end
end
