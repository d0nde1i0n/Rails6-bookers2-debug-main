class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one_attached :profile_image
  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy

  # 下記コメントは回答を見て修正を実施
  # 自分がフォローされる（被フォロー）側の可能性
  has_many :reverse_of_relationships,class_name: 'Relationship',foreign_key: :followed_id,dependent: :destroy
  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, foreign_key: :follower_id,dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers,through: :reverse_of_relationships, source: :follower
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings,through: :relationships,source: :followed

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,length: {maximum: 50}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # あるユーザが引数で渡されたuserにフォローされているか調べるメソッド
  def is_follower_by?(user)
    reverse_of_relationships.find_by(follower_id: user.id).present?
  end

end
