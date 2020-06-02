module OasDivider
  class SchemaObject
    attr_accessor :schema_name, :schema_object

    def initialize(schema_name, schema_object)
      @schema_name = schema_name
      @schema_object = schema_object
    end

    def to_file
      convert_ref
      YAML.dump(schema_object, File.open( File.join(directory, file_name) , 'w') )
    end

    def directory
      'components/schemas'
    end

    def file_name
      "#{schema_name}.yml"
    end

    def ref
      File.join(directory, file_name)
    end

    def convert_ref
      RelativeDocumentReferencer.execute(schema_object, 2)
    end
  end
end
