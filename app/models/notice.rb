class Notice
  include NoBrainer::Document
  include Pusherable

  pusherable serializer: NoticeSerializer

  field :title

  attr_accessor :client_id
end