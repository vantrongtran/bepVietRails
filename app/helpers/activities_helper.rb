module ActivitiesHelper

  def activity_link activity
    user = activity.user
    if Post::UserPost.name == activity.target.class.name &&  activity.action_type == :write
      return t("activities.activity",
        user: link_to(user.name, activity.user),
        action: t("activities.#{activity.action_type}"),
        type: link_to(activity.target.title, activity.target)
        )
    end
    type_object = case activity.target.class.name
    when User.name
        link_to(activity.target.name, activity.target)
      when Post::UserPost.name
        t("activities.post", user: link_to(activity.target.user.name, activity.target.user), target: link_to(activity.target.title, activity.target))
      when Comment.name
        if activity.target.target.class.name == Post::UserPost.name
          t("activities.post", user: link_to(activity.target.user.name, activity.target.user), target: link_to(activity.target.target.title, activity.target.target))
        else
          comment = activity.target
          t("activities.comment_like",
            user: link_to(comment.user.name, comment.user),
            target: link_to(comment.target.title, comment.target)
            )
        end
      else
        link_to(activity.target.title, activity.target)
      end
      t("activities.activity",
        user: link_to(user.name, activity.user),
        action: t("activities.#{activity.action_type}"),
        type: type_object
       )
  end
end
