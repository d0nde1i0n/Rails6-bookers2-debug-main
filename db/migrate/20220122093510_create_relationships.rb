class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|

      t.integer :follower_id #フォローする側のユーザid
      t.integer :followed_id #フォローされる側のユーザid

      t.timestamps
    end
  end
end
