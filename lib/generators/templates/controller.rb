class <%= class_path_namespace %><%= plural_class_name %>Controller < <%= class_path_namespace %>ApiController
  before_filter :find_<%= singular_file_name %>, :except => [:index, :create]

  def index
    respond_with <%= singular_class_name %>.all
  end

  def create
    respond_with <%= singular_class_name %>.create <%= singular_file_name %>_params
  end

  def show
    respond_with @<%= singular_file_name %>
  end

  def update
    respond_with @<%= singular_file_name %>.update_attributes <%= singular_file_name %>_params
  end

  def destroy
    respond_with @<%= singular_file_name %>.destroy
  end

  protected
  def find_<%= singular_file_name %>
    @<%= singular_file_name %> = <%= singular_class_name %>.find params[:id]
  end

  def <%= singular_file_name %>_params
    {<% whitelisted_attributes.each do |attribute| %>
      :<%= attribute %> => params[:<%= attribute %>],<% end %>
    }
  end

  def <%= singular_file_name %>_url(<%= singular_file_name %>)
    <%= singular_route %> <%= singular_file_name %>
  end
end
