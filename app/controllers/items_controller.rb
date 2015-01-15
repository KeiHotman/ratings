class ItemsController < ApplicationController
  before_action :authenticate_user!, only: %i(rating)

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @rating = Rating.find_by(item: @item, user: current_user) if current_user
  end

  def rating
    @item = Item.find(params[:id])
    @rating = Rating.find_or_initialize_by(item: @item, user: current_user)
    @rating.score = params[:score]
    @rating.taken = true

    respond_to do |format|
      if @rating.save
        format.html { redirect_to @item, notice: '評価が登録されました。' }
        format.js
      else
        format.html { redirect_to @item, alert: '評価に失敗しました。' }
        format.js
      end
    end
  end
end
