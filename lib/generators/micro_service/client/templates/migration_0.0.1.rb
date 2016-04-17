class AddMicroServiceClient001Migration < ActiveRecord::Migration
	def self.up
		create_table :micro_service_clients do |t|
			t.string :secret # Secret to be used
			t.string :install_url  # POST here when install successful
			t.string :uninstall_url # POST here when uninstall successful
			t.integer :attempt, default: 0
			t.boolean :uninstalled, default: 0

			t.timestamps null: false
		end
	end

	def self.down
		drop_table :micro_service_clients
	end
end