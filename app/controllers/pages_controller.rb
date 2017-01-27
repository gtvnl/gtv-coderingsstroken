class PagesController < ApplicationController
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  def index
    @pages = Page.all
  end

  # GET /pages/1
  def show
    @lines = @page.lines.order_by(number: :asc)

    respond_to do |format|
      format.html
      format.pdf do
        options = { page_size: @page.size, page_layout: @page.layout.to_sym }
        pdf = CoderingsstrokenPdf.new(@page, view_context, options)
        send_data pdf.render, filename:
        "#{@page.project_number}_#{@page.title}_#{@page.created_at.strftime("%d/%m/%Y")}.pdf",
        type: "application/pdf"
      end
    end
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  def create
    @page = Page.new(page_params)

    if @page.save
      num_of_lines = params[:page][:num_of_lines].to_i

      num_of_lines.times do |i|
        line = Line.create(page: @page, number: i + 1)

        12.times do |i|
          item = Item.create(line: line, number: i + 1, title: "Gr.#{i + 1}")
        end

      end

      redirect_to pages_url, notice: 'Pagina aangemaakt.'
    else
      render :new
    end
  end

  # PATCH/PUT /pages/1
  def update
    @old_num_of_lines = @page.num_of_lines
    if @page.update(page_params)
      @new_num_of_lines = params[:page][:num_of_lines]

      if @new_num_of_lines != @old_num_of_lines
        if @new_num_of_lines > @old_num_of_lines
          # Add lines
        elsif @new_num_of_lines < @old_num_of_lines
          # Delete lines
        end
      end
      redirect_to @page, notice: 'Pagina gewijzigd.'
    else
      render :edit
    end
  end

  # DELETE /pages/1
  def destroy
    @page.destroy
    redirect_to pages_url, notice: 'Pagina verwijderd.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def page_params
      params.require(:page).permit(:title, :num_of_lines, :layout, :size, :project_number)
    end
end
