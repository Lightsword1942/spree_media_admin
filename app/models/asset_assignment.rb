class AssetAssignment < ActiveRecord::Base
	attr_accessible :viewable, :asset

  belongs_to :asset, class_name: 'Spree::Asset'
  belongs_to :viewable, :polymorphic => true
end