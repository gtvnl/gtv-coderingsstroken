class Item
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include Sizeable

  belongs_to :line

  has_one :page, through: :line

  field :title, default: "Gr. "
  field :description

  field :number, type: Integer, default: 1

  field :modulen, type: Integer, default: 1

  def width_in_mm
    modulen * Item.module_size.mm
  end



end
