class AddAgencyAssociationToRoute < ActiveRecord::Migration[7.1]
  def change
    add_reference :routes, :agency
  end
end
