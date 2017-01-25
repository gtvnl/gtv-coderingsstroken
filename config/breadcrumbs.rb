crumb :root do
  link "Home", root_path
end

crumb :pages do
  link "Alle Paginas", pages_path
end

crumb :page do |page|
  parent :pages
  link page.title, page
end

crumb :lines do |lines|
  @page = Page.find(params[:page_id])

  parent :pages
  link @page.title, @page
  link "Alle Regels", page_lines_path
end

crumb :line do |line|
  parent :pages
  link line.page.title, line.page
  link "ALLE REGELS", page_lines_path
  link "Regel #{line.number}", page_line_path(line)
end

crumb :items do |items|
  @page = Page.find(params[:page_id])
  @regel = Line.find(params[:line_id])

  parent :lines
  link "Regel #{@regel.number}", page_line_path(@page, @regel)
  link "ALLE MODULEN", page_line_items_path
end

crumb :item do |item|
  @page = Page.find(params[:page_id])
  @regel = Line.find(params[:line_id])

  parent :items
  link "Module #{item.number}"
end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
