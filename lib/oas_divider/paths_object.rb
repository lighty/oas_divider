module OasDivider
  class PathsObject
    attr_accessor :path, :path_item_objects

    def initialize(path, path_item_objects)
      @path = path
      @path_item_objects = path_item_objects
    end

    def to_file
      make_directory
      convert_ref
      YAML.dump(path_item_objects, File.open( File.join(directory, file_name) , 'w') )
    end

    def make_directory
      FileUtils.mkdir_p( directory )
    rescue => e
      puts "path: #{@path}"
      throw e
    end

    def interlevel_directory
      @path.split('/').length > 2 ? @path.split('/')[1..-2].map {|dir| dir.gsub(/[{}]/,"")} : ''
    end

    def directory
      File.join( 'paths' , interlevel_directory)
    end

    def file_name
      "#{@path.split('/').pop.gsub(/[{}]/,"")}.yml"
    end

    def ref
      File.join(directory, file_name)
    end

    def convert_ref
      RelativeDocumentReferencer.execute(path_item_objects, 1 + interlevel_directory.size)
    end
  end
end
