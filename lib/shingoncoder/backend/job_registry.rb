module Shingoncoder
  module Backend
    class JobRegistry

      class << self
        def create(input)
          raise ArgumentError, "Required argument ':input' is missing" unless input.key?(:input)
          outputs = input.delete(:outputs)
          outputs ||= default_output(input)
          Job.create(Job.input_column_name => input) do |job|
            outputs.each do |val|
              raise ArgumentError, "Output directive must have a url" unless val.key?(:url)

              job.outputs.build(Output.input_column_name => val)
            end
          end
        end

        def create_tables!
          Job.create_table!
          Output.create_table!
        end

        def drop_tables!
          Job.drop_table!
          Output.drop_table!
        end

        private

          def default_output(input)
            [{ url: "#{input.fetch(:input)}.mp4" }]
          end
      end

      class Job < ActiveRecord::Base
        ##
        # :singleton-method:
        # Customizable data column name. Defaults to 'data'.
        cattr_accessor :input_column_name
        self.input_column_name = 'input'
        has_many :outputs

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

      class Output < ActiveRecord::Base
        belongs_to :job

        ##
        # :singleton-method:
        # Customizable data column name. Defaults to 'data'.
        cattr_accessor :input_column_name
        self.input_column_name = 'input'
        serialize input_column_name, JSON

        def url
          self[input_column_name]['url']
        end

        def config
          self[input_column_name]
        end

        class << self
          def drop_table!
            connection.schema_cache.clear_table_cache!(table_name)
            connection.drop_table table_name
          end

          def create_table!
            connection.schema_cache.clear_table_cache!(table_name)
            connection.create_table(table_name) do |t|
              t.references :job, index: true, foreign_key: true
              t.text input_column_name
            end
          end
        end
      end
    end
  end
end
