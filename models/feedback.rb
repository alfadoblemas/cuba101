class Feedback < Ohm::Model
  attribute :name
  attribute :email
  attribute :suggestion

  reference :talk, :Talk
end
