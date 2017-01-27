class Item
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include Sizeable


  validate { errors.add(:modulen, "Een regel kan maximaal #{Item.max_aantal_modulen} modulen hebben.") if self.too_many_modules? }

  belongs_to :line

  has_one :page, through: :line

  field :title, default: "Gr. "
  field :description

  field :number, type: Integer, default: 1

  field :modulen, type: Integer, default: 1

  def width_in_mm
    modulen * Item.module_size.mm
  end

  def too_many_modules?
    self.line.num_of_modules + self.modulen  > Item.max_aantal_modulen
  end

end
