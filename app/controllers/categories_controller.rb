class CategoriesController < ApplicationController

  def index
    @categories = Category.includes(:translations, :users,  :subscribes).order('created_at DESC')
  end

  def show
    @category = Category.find(params[:id])
    @images = @category.images.page(params[:page]).per(5)
  end

  def subscribe
    user_subscribe = current_user.subscribes.new(category_id: params[:category_id])
    if user_subscribe.save
      Event.create(user_id: current_user.id, related_id: user_subscribe.category.id, user_action: 'subscribed')
      render nothing: true
    end
  end

  def unsubscribe
    user_unsubscribe = Subscribe.where('user_id = :user_id AND category_id = :category_id', user_id: current_user.id, category_id: params[:category_id]).first
    if user_unsubscribe.destroy
      Event.create(user_id: current_user.id, related_id: user_unsubscribe.category.id, user_action: 'unsubscribed')
      render nothing: true
    end
  end

end