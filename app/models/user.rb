class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one_attached :profile_image
  has_many :books,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy

  #フォローする側のテーブルとのアソシエーション
  has_many :relationships, foreign_key: :follower_id
  #あるユーザがフォローしている人全員を取得する
  has_many :followers,through: :relationships, source: :followed

  # フォローされる側からのテーブルとのアソシエーション
  has_many :reverse_of_relationships,class_name: 'Relationship',foreign_key: :followed_id
  # フォローされる側からフォローしているユーザを取得する
  has_many :followeds,through: :reverse_of_relationships,source: :follower

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction,length: {maximum: 50}

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  # あるユーザが引数で渡されたuserにフォローされているか調べるメソッド
  def is_followed_by?(user)
    reverse_of_relationships.find_by(follower_id: user.id).present?
  end
end
