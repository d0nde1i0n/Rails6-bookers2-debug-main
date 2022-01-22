class Relationship < ApplicationRecord

  # フォローする側のUserテーブルとのアソシエーション
  belongs_to :follower,class_name: 'User'
  # フォローされる側のUserテーブルとのアソシエーション
  belongs_to :followed,class_name: 'User'
end
