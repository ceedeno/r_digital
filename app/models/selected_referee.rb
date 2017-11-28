class SelectedReferee < ApplicationRecord
  belongs_to :article
  belongs_to :referee_1, class_name: 'User'
  belongs_to :referee_2, class_name: 'User'
  belongs_to :referee_3, class_name: 'User'



  #delegate :referee_1_id, :referee_2, :referee_3, to: :article


  after_update :set_referee_assigned_date



  def set_referee_assigned_date
    if saved_change_to_referee_1_id? || saved_change_to_referee_2_id? || saved_change_to_referee_3_id?
      update_attribute(:referee_assigned_date, Date.today)
    end
  end


end
