require "prawn/measurement_extensions"

class CoderingsstrokenPdf < Prawn::Document

  def initialize(page, view, options)
    super(options)
    @page = page
    @view = view
    logo
    draw_table
  end

  def logo
    logopath =  "#{Rails.root}/app/assets/images/gtv.png"
    image logopath, :width => 83, :height => 55
    move_down 10
    draw_text "#{@page.project_number} - #{@page.title}", :at => [100, 490], size: 22 if @page.layout == 'landscape'
  end

  def draw_table
    @page.lines.each do |line|
      widths = Item.where(line: line).collect.pluck(:width_in_mm)

      titles = Item.where(line: line).collect.pluck(:title)
      descriptions = Item.where(line: line).collect.pluck(:description)

      widths.unshift(8.mm)

      titles.unshift("")
      descriptions.unshift(line.number)

        table([descriptions],
        cell_style: {
            height: line.height_in_mm / 2,
            overflow: :truncate,
            align: :center,
            valign: :bottom,
            :border_lines => [:dotted, :solid, :dotted, :dotted]
          },
          column_widths: widths
          )

          table([titles],
          cell_style: {
              height: line.height_in_mm / 2,
              overflow: :truncate,
              align: :center,
              valign: :bottom,
              :border_lines => [:dotted, :solid, :solid, :dotted]
            },
            column_widths: widths
            )

    end
  end



end
