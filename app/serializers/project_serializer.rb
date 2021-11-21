class ProjectSerializer
  include JSONAPI::Serializer

  attributes :name
  has_many :tasks
end
