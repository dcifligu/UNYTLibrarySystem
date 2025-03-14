class JournalDecorator < ApplicationDecorator
  def decorated_title
    "<h1 class='text-3xl font-bold text-gray-900'>#{title}</h1>".html_safe
  end
  
  def decorated_publisher
    "<p class='mt-2 text-gray-500'>#{publisher}</p>".html_safe
  end
  
  def decorated_description
    "<p class='mt-4 text-gray-700'>#{description}</p>".html_safe
  end
  
  def decorated_details
    content = ""
    content += "<p class='text-sm text-gray-500'>ISSN: #{issue}</p>" if issue.present?
    content += "<p class='text-sm text-gray-500'>Publication Year: #{publish_year}</p>" if publish_year.present?
    content += "<p class='text-sm text-gray-500'>Status: #{current_status}</p>"
    
    "<div class='mt-6'>#{content}</div>".html_safe
  end
  
  # Full display for the details view
  def display_details(view_context)
    <<-HTML
    <div class="bg-gray-50 min-h-screen">
      <div class="max-w-6xl mx-auto px-4 py-12 sm:px-6 lg:px-8">
        <div class="bg-white rounded-xl shadow-md overflow-hidden">
          <div class="p-8">
            #{decorated_title}
            #{decorated_publisher}
            #{decorated_description}
            #{decorated_details}
            <div class="mt-6">
              #{view_context.link_to "Reserve", view_context.reserve_journal_path(object), class: "inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md shadow-sm text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"}
            </div>
          </div>
        </div>
      </div>
    </div>
    HTML
    .html_safe
  end
end