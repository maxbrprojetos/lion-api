class Notice
  include NoBrainer::Document
  include Pusherable

  pusherable serializer: NoticeSerializer

  field :title
end