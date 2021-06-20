module NotificationsHelper
  def notification_form(notification)
    visitor=link_to notification.visitor.name, notification.visitor, style:"font-weight: bold;"
    "#{visitor}があなたをフォローしました"
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end