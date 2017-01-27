class Line
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include Sizeable

  belongs_to :page
  has_many :items, dependent: :destroy

  field :number, default: 1, required: true
  field :modules

  field :num_of_modules, default: 12, required: true

  field :height, default: Line.line_height

  def height_in_mm
    height.mm
  end

  def num_of_modules
    self.items.sum(:modulen)
  end

end
