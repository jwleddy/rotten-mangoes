class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  # def account_destroyed_email(user)
  #
  # end

  def new_task(task)
    @task = task
    @user = task.user
    mail(to: "me@me.com", subject: "New Task # #{task.id}")
  end

end
