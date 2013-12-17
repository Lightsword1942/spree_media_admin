Spree::Admin::ImagesController.class_eval do 

  create.after :create_asset_assignment
  update.after :create_asset_assignment

  def create_asset_assignment
    viewable = Variant.find(@image.viewable_id)
    asset_assignment = AssetAssignment.create(:viewable => viewable, :asset => @image)
  end
end 