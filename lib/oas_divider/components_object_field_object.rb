module OasDivider
  class ComponentsObjectFieldObject
    attr_accessor :field_name, :field_object

    def initialize(field_name, field_object)
      @field_name = field_name
      @field_object = field_object
    end

    def to_file
      convert_ref
      YAML.dump(field_object, File.open( File.join(directory, file_name) , 'w') )
    end

    def directory
      'components'
    end

    def file_name
      "#{field_name}.yml"
    end

    def ref
      File.join(directory, file_name)
    end

    def convert_ref
      RelativeDocumentReferencer.execute(field_object, 1)
    end
  end
end
