class AddDefaultNodeTypeToNodes < ActiveRecord::Migration
    def self.up
        change_column_default :nodes, :node_type_id, 1
    end

    def self.down
    end
end
