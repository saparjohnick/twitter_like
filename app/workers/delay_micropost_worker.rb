class DelayMicropostWorker
  include Sidekiq::Worker

  def perform(params)
    params = ActiveSupport::HashWithIndifferentAccess.new(params)
    user = User.friendly.find(params[:user_id])
    user.microposts.create(params)
  end
end
