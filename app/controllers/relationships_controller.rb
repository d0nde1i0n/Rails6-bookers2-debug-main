class RelationshipsController < ApplicationController
# ログインしていないユーザは本コントローラを参照できないようにする。
before_action :authenticate_user!

  def create
    # ログインユーザidとそのフォロー対象のユーザidを取得し、
    # 変数paramsに格納
    # (follower_id,fllowed_id) = (ログインユーザid,フォロー対象のユーザid)
    # フォローするユーザ側から見た時の操作
    relationship = current_user.relationships.new(followed_id: params[:user_id])
    # relationshipsテーブルに必要な情報を全て格納できたため、DBに格納
    relationship.save
    # リダイレクト先はリンク元のページを指定
    redirect_to request.referer
  end

  def destroy
    # ログインユーザidとログインユーザがフォローしているユーザのidを取得し、
    # 変数paramsに格納
    # (follower_id,fllowed_id) = (ログインユーザid,フォロー対象のユーザid)
    relationship = current_user.relationships.find_by(followed_id: params[:user_id])
    # relationshipsテーブルのレコードの中から、follower_id(ログインユーザid)、
    # followed_id(フォロー対象のユーザid）が一致するレコードを削除
    relationship.destroy
    # リダイレクト先はリンク元のページを指定
    redirect_to request.referer
  end

end
