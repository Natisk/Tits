# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  image_id   :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Comment < ActiveRecord::Base

  after_create :track_comment

  default_scope order('created_at DESC')

  attr_accessible :body, :image_id

  belongs_to :user, counter_cache: true
  belongs_to :image, counter_cache: true

  validates :body, presence: true, length: {minimum: 2, maximum: 255}
  validates :user_id, presence: true, numericality: {only_integer: true, greater_than: 0}

  def track_comment
    Event.create(user_id: self.user_id , related_id: self.image_id, user_action: 'comment add')
  end

end
