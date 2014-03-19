# == Schema Information
#
# Table name: notices
#
#  id         :uuid             not null, primary key
#  title      :text
#  type       :string(255)      default("warning")
#  created_at :datetime
#  updated_at :datetime
#  app        :string(255)
#

class Notice < ActiveRecord::Base
  include Pusherable

  validates :type, inclusion: { in: %w(warning error) }
  validates :app, presence: true
  validates :title, presence: true

  private

  def self.inheritance_column
    '_type_disabled'
  end
end
