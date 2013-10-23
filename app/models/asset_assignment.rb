class AssetAssignment < ActiveRecord::Base
  belongs_to :asset, class_name: 'Spree::Asset'
  belongs_to :viewable, :polymorphic => true
end