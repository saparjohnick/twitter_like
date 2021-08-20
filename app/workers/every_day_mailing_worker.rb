class EveryDayMailingWorker
  include Sidekiq::Worker

  def perform(*args)
    Users.each do |user|
      UserNotifyMailer.with(user: user).notify_email.deliver_now
    end
  end
end
