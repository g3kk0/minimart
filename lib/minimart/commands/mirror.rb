module Minimart
  module Commands
    # Mirror is the main entrance point for the mirroring portion of Minimart.
    # Given a directory, and a path to a config file, this class
    # will generate an inventory.
    class Mirror

      # @return [String] The path to the inventory configuration file.
      attr_reader :inventory_config

      # @return [String] The directory to store the inventory.
      attr_reader :inventory_directory

      # @return [Boolean] Determine whether or not to resolve cookbook dependencies.
      attr_reader :skip_dependencies

      # @param [Hash] opts
      # @option opts [String] :inventory_directory The directory to store the inventory.
      # @option opts [String] :inventory_config The path to the inventory configuration file.
      # @option opts [Boolean] :skip_dependencies Determine whether or not to resolve cookbook dependencies.
      def initialize(opts)
        @inventory_directory = opts[:inventory_directory]
        @inventory_config    = Minimart::Mirror::InventoryConfiguration.new(opts[:inventory_config])
        @skip_dependencies   = opts[:skip_dependencies]
      end

      # Generate the inventory.
      def execute!
        builder = Minimart::Mirror::InventoryBuilder.new(inventory_directory, inventory_config, skip_dependencies)
        builder.build!
      end
    end
  end
end
