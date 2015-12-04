class UserSerializer < ActiveModel::Serializer
  embed :ids

  attributes :id, :avatar_url, :nickname
end
