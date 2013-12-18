class RestControllerGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def copy_controller_file
    template 'controller.rb', File.join("app/controllers", class_path_dir, "#{plural_file_name}_controller.rb")
  end

  protected
  def class_path_dir
    File.join parse_namespace.map(&:underscore)
  end

  def class_path_namespace
    parse_namespace.map(&:titleize).map{|fragment| "#{fragment}::"}.join
  end

  def parse_namespace
    class_path = name.include?('/') ? name.split('/') : name.split('::')
    class_path.pop
    class_path
  end

  def class_name
    file_name.classify
  end

  def plural_class_name
    @plural_class_name ||= class_name.pluralize
  end

  def singular_class_name
    @singular_class_name ||= class_name.singularize
  end

  def singular_file_name
    @singular_file_name ||= file_name.singularize
  end

  def singular_route
    class_path = name.include?('/') ? name.split('/') : name.split('::')
    "#{class_path.map(&:underscore).join '_'}_path"
  end

  def whitelisted_attributes
    args
  end
end
