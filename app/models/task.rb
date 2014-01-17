class Task < ActiveRecord::Base
  include Pusherable

  pusherable serializer: TaskSerializer
end
