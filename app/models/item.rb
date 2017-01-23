class Item
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  belongs_to :line

  has_one :page, through: :line

  field :name, default: "Groep"
  field :number, default: 1, required: true

  field :width, default: 17.5

end
