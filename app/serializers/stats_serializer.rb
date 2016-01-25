class StatsSerializer < ActiveModel::Serializer
  attributes :id, :avatar_url, :nickname, :count

  def id
    object["id"]
  end

  def avatar_url
    object["avatar_url"]
  end

  def nickname
    object["nickname"]
  end

  def count
    object["count"]
  end

end
