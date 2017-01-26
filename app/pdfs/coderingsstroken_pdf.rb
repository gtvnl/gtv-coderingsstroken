require "prawn/measurement_extensions"

class CoderingsstrokenPdf < Prawn::Document

  def initialize(page, view, options)
    super(options)
    # , page_size: @page.size, page_layout: @page.layout
    @page = page
    @view = view
    logo
    draw_table
  end

  def logo
    logopath =  "#{Rails.root}/app/assets/images/gtv.png"
    image logopath, :width => 83, :height => 55
    move_down 10
    draw_text @page.project_number, :at => [220, 775], size: 22
  end

  def draw_table
    @page.lines.each do |line|
      widths = Item.where(line: line).collect.pluck(:width_in_mm)
      data = Item.where(line: line).collect.pluck(:title)
      widths.unshift(8.mm)
      data.unshift(line.number)
      table([data], cell_style: {height: line.height_in_mm }, column_widths: widths)
    end
  end



end
