require "oas_divider/version"
require 'yaml'
require 'fileutils'

require 'oas_divider/components_object_field_object'
require 'oas_divider/paths_object'
require 'oas_divider/relative_document_referencer'
require 'oas_divider/schema_object'

module OasDivider
  class Cli

    def initialize(file_name)
      @file_name = file_name
    end

    def divide
      load_file_as_open_api_object
      save_divided_files
      save_open_api_object_as_root_file
    end

    private

    def save_divided_files
      open_api_object.keys.each do |open_api_object_field|
        if open_api_object_field === "paths" 
          FileUtils.mkdir_p('paths')
          paths_objects = open_api_object[open_api_object_field]
          paths_objects.keys.each do |path|
            path_object = PathsObject.new(path, paths_objects[path]) # 一つのpathオブジェクト。postなどがキー
            path_object.to_file
            open_api_object[open_api_object_field][path] = { "$ref" => path_object.ref }
          end
        end

        if open_api_object_field === "components" 
          FileUtils.mkdir_p('components')
          components_objects = open_api_object[open_api_object_field]
          components_objects.keys.each do |components_object_field|
            if components_object_field === 'schemas'
              FileUtils.mkdir_p('components/schemas')
              schmas = components_objects[components_object_field]
              schmas.keys.each do |schema_name|
                schema_object = SchemaObject.new(schema_name, schmas[schema_name])
                schema_object.to_file
                open_api_object[open_api_object_field][components_object_field][schema_name] = { "$ref" => schema_object.ref }
              end
            else
              field_object = ComponentsObjectFieldObject.new(components_object_field, components_objects[components_object_field])
              field_object.to_file
              open_api_object[open_api_object_field][components_object_field] = { "$ref" => field_object.ref }
            end
          end
        end
      end
    end

    def load_file_as_open_api_object
      self.open_api_object = YAML.load_file(file_name)
    end

    def save_open_api_object_as_root_file
      YAML.dump(open_api_object, File.open('swagger_root.yml', 'w'))
    end

    attr_accessor :file_name, :open_api_object
  end
end
