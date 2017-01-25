class Line
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  belongs_to :page

  has_many :items, dependent: :delete

  field :number, default: 1, required: true
  field :modules

  field :num_of_modules, default: 12, required: true
  field :height, default: 2.15


end
