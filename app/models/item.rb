class Item
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include Sizeable


  validate { errors.add(:modulen, "Een regel kan maximaal #{Item.max_aantal_modulen} modulen hebben.") if self.too_many_modules? }
  after_destroy :check_modules

  belongs_to :line

  has_one :page, through: :line

  field :title, default: "Gr. "
  field :number, default: 1

  field :modulen, type: Integer, default: 1

  def width_in_mm
    modulen * Item.module_size.mm
  end

  def too_many_modules?
    self.line.num_of_modules + self.modulen  > Item.max_aantal_modulen
  end

  def check_modules
    num_of_modules = self.line.items.sum(:modulen)

    if num_of_modules < 12
        diff = 12 - num_of_modules

        num = [1,2,3,4,5,6,7,8,9,10,11,12] - self.line.items.select.pluck(:number)

        diff.times do
          Item.create(line: self.line, number: num[0], title: "")
        end
    end
  end

end
