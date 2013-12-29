# == Schema Information
#
# Table name: notices
#
#  id         :uuid             not null, primary key
#  title      :text
#  type       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Notice < ActiveRecord::Base
  include Pusherable

  pusherable serializer: NoticeSerializer

  validates :type, inclusion: { in: ['warning', 'error'] }

  attr_accessor :client_id

  def self.inheritance_column
    '_type_disabled'
  end
end
