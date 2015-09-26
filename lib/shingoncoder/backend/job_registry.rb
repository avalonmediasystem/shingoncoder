module Shingoncoder
  module Backend
    class JobRegistry

      class << self
        def create(input)
          Job.create(Job.input_column_name => input)
        end
      end

      class Job < ActiveRecord::Base
        ##
        # :singleton-method:
        # Customizable data column name. Defaults to 'data'.
        cattr_accessor :input_column_name
        self.input_column_name = 'input'

        serialize input_column_name, JSON

        class << self
          def drop_table!
            connection.schema_cache.clear_table_cache!(table_name)
            connection.drop_table table_name
          end

          def create_table!
            connection.schema_cache.clear_table_cache!(table_name)
            connection.create_table(table_name) do |t|
              t.text input_column_name
            end
          end
        end
      end
    end
  end
end
