module ApplicationHelper

  def name_with_status(name, status, user_id)
    link_to(name, user_path(user_id), :class => "name") +
      content_tag(:span, status, :class => "status status-#{status}", :id => "status-#{user_id}") +
      link_to("Update", status_user_path(user_id), :class => "update-link")
  end

  def member_status(name, status, user_id)
    link_to(name, user_path(user_id), :class => "name") +
      content_tag(:span, status, :class => "status status-#{status}", :id => "status-#{user_id}") +
      link_to("Remove", leave_team_user_path(user_id), :class => "update-link")
  end

end