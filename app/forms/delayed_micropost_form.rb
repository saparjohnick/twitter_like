class DelayedMicropostForm
  include ActiveModel::Model

  validates :user, presence: true
  validates :content, presence: true, length: { maximum: 140 }

  attr_reader :user, :pub_date, :content, :is_delayed

  def initialize(params)
    @user = params[:user]
    @content = params[:content]
    @is_delayed = params[:is_delayed]
    @pub_date = params[:pub_date]
    @picture = params[:picture]
  end

  def submit
    raise NotImplementedError, 'No user, content or picture provided' unless @user && (@content || @picture)

    if @pub_date.empty? && @is_delayed
      create_immidiate_micropost
    else
      create_delayed_micropost
    end
  end

  private 

  def micropost_pub_date
    Time.parse(@pub_date)
  end

  def create_delayed_micropost
    DelayMicropostWorker.perform_at(micropost_pub_date, user_id: @user.id, content: @content)
  end

  def create_immidiate_micropost
    @user.microposts.create("content": @content, "picture": @picture)
  end
end
