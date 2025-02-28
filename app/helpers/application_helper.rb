module ApplicationHelper
  def hide_nav?
    devise_pages_without_nav = [
      { controller: "registrations", action: "new" },
      { controller: "registrations", action: "create" },
      { controller: "sessions", action: "new" },
      { controller: "sessions", action: "create" }
      # Add other controller/action pairs as needed
    ]

    devise_pages_without_nav.any? do |page|
      controller_name == page[:controller] && action_name == page[:action]
    end
  end
end
