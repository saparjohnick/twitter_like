class DelayedMicropostForm
  include ActiveModel::Model

  validates :user, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  attr_accessor :content, :is_delayed, :pub_date
  attr_reader :user

  def initialize(params)
    @user = params[:user]
    @content = params[:content]
    @is_delayed = params[:is_delayed]
    @pub_date = params[:pub_date]
    @picture = params[:picture]
  end

  def submit
    raise NotImplementedError, 'No user, content or picture provided' unless @user && (@content || @picture)

    if @is_delayed == true
      DelayMicropostWorker.perform_at(micropost_pub_date, user_id: @user.id, content: @content)
    else
      @user.microposts.create("content": @content, "picture": @picture)
    end
  end

  def micropost_pub_date
    Time.parse(@pub_date)
  end
end
