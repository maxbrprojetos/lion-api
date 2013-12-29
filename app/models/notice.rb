class Notice
  include NoBrainer::Document
  include Pusherable

  pusherable serializer: NoticeSerializer

  field :title
  field :type

  validates :type, inclusion: { in: ['warning', 'error'] }

  attr_accessor :client_id
end