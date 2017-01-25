class Page
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  has_many :lines, dependent: :delete

  field :title, default: 'Pagina 1', required: true

  field :num_of_lines, default: 10, required: true


  VALID_SIZE = ["A4", "A3"]
  field :size, :type => String, :in => VALID_SIZE, :default => VALID_SIZE.first

  def self.sizes
     [
       {"A4" => { width: 210, height: 297 }},
       {"A3" => { width: 297, height: 420 }}
     ]
  end

  def max_cols
    columns = []
    self.lines.each do |line|
      columns << line.items.count
    end
    return columns.max
  end

end
