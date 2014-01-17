class Task < ActiveRecord::Base
  include Pusherable

  pusherable serializer: TaskSerializer

  belongs_to :user
end
