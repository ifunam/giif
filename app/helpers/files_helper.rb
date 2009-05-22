module FilesHelper

#   def render_file_form
#     render(:partial => "file", :object => OrderFile.new, :locals => {:index => "INDEX"}, :collection => @order.files)
#   end

#   def javascript_for_file_form_index
#     "fileForm = new Subform('#{escape_javascript(render_file_form)}', #{@order.files.length},'files');"
#   end

#   def content_for_file_form_head
#     content_for :head do 
#       javascript_tag(javascript_for_file_form_index)
#     end
#   end

#   def index_file_form(file, file_counter, index)
#     index ||= file_counter
#     #new_or_existing = file.new_record? ? 'new' : 'existing'
#     id_or_index = file.new_record? ? index : file.id 
#     #prefix = "order[files_attributes]" 
#     return id_or_index
#   end

end
