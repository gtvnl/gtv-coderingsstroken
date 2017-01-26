class Page
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include Sizeable

  has_many :lines, dependent: :delete

  field :project_number, default: "#{Time.now.year}00"
  field :title, default: 'Pagina 1', required: true

  field :num_of_lines, default: 7, required: true


  field :size, :type => String, :in => self.paper_sizes.keys, :default => "A4"
  field :layout, :type => String, :in => ["portrait", "landscape"], :default => "landscape"

  def max_cols
    columns = []
    self.lines.each do |line|
      columns << line.items.count
    end
    return columns.max
  end

end
