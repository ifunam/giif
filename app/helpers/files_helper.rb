module FilesHelper

  def render_file_form
    render(:partial => "file", :object => OrderFile.new, :locals => {:index => "INDEX"})
  end

  def javascript_for_file_form_index
    "fileForm = new Subform('#{escape_javascript(render_file_form)}', #{@order.files.length},'files');"
  end
  def content_for_file_form_head
    content_for :head do 
      javascript_tag(javascript_for_file_form_index)
    end
  end

end
