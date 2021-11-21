class CommentSerializer
  include JSONAPI::Serializer

  attributes :name
  belongs_to :task
end
