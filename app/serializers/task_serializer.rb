class TaskSerializer
  include JSONAPI::Serializer

  attributes :name, :completed
  belongs_to :project
  has_many :comments
end
