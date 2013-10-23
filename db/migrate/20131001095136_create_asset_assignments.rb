class CreateAssetAssignments < ActiveRecord::Migration

  def change
    create_table :asset_assignments do |t|
      t.references :viewable, :polymorphic => true
      t.references :asset
    end

    add_index :asset_assignments, [:viewable_id], :name => 'index_asset_assignments_on_viewable_id'
    add_index :asset_assignments, [:viewable_type], :name => 'index_asset_assignments_on_viewable_type'
    add_index :asset_assignments, [:asset_id], :name => 'index_asset_assignments_on_asset_id'
  end
end
