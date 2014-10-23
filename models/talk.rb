class Talk < Ohm::Model
  attribute :title
  attribute :description

  collection :feedbacks, :Feedback
end
