class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :image, destroy: false

  has_many :post_comments, dependent: :destroy

  has_many :reviews, dependent: :destroy
  has_many :good_reviews, through: :goods, source: :review # has_many a, through: :b で、bを通したuser.aが使える。aをreviewsにするとhas_many :reviewsと被ってしまう為、sourceにモデル名を書いた上でaの名前を変えている
  has_many :bad_reviews, through: :bads, source: :review # has_many a, through: :b で、bを通したuser.aが使える。aをreviewsにするとhas_many :reviewsと被ってしまう為、sourceにモデル名を書いた上でaの名前を変えている
  
  has_many :interests, dependent: :destroy

  has_many :goods
  has_many :bads

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #フォロー取得
  has_many :following_user, through: :follower, source: :followed #自分がフォローしている人
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #フォロワー取得
  has_many :follower_user, through: :followed, source: :follower #自分をフォローしている人
  
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy #自分からの通知
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy #相手からの通知

  #ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  #ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  #フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end
  
  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end


end
