class Page
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  has_many :lines, dependent: :delete 

  field :name, default: 'Pagina 1', required: true
  field :num_of_lines, default: 10, required: true

end
