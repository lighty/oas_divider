module OasDivider
  class RelativeDocumentReferencer
    def self.execute(root, depth)
      new(root, depth).execute
    end

    def initialize(root, depth)
      @root = root
      @depth = depth
    end

    def execute
      lookup(root)
      root
    end

    # hashで、keyが$refならconvert
    # hashかarrayならlookup
    # そうでないならなにもしない
    def lookup(object)
      if object.is_a? Array
        object.each { |value| lookup(value) if value.is_a?(Hash) || value.is_a?(Array) }
      else
        object.each do |key, value|
          set_converted_value(object, key, value) if key === "$ref"
          lookup(value) if value.is_a?(Hash) || value.is_a?(Array)
        end
      end
    end

    def set_converted_value(object, key, value)
      object[key] = convert(value)
    end
    
    def convert(ref)
      # componentから取得することしか考えない
      if ref.split('/')[2] === 'schemas'
        "../" * depth + "#{ref.split('/')[1..3].join('/')}.yml"
      else
        "../" * depth + "#{ref.split('/')[1..2].join('/')}.yml#/#{ref.split('/')[3]}"
      end
    end

  private
    attr :root, :depth
  end
end
