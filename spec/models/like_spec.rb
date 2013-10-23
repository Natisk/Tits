# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  image_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Like do

  context 'relations and validations' do
    it {should belong_to(:user)}
    it {should belong_to(:image)}
    it {should allow_mass_assignment_of(:user_id)}
    it {should allow_mass_assignment_of(:image_id)}
  end

  it 'hooks for likes' do
    like_img = FactoryGirl.create(:image)
    like_user = FactoryGirl.create(:user)
    like = like_user.likes.new(image_id: like_img.id)
    events = Event.all
    like.save
    #events.count.should eq(1)
  end

end
