class DefaultStatus < ActiveRecord::Migration
  def change
    change_column("cat_rental_requests", "status", "string", :default => "undecided")
  end
end
