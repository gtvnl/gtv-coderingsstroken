class LinesController < ApplicationController
  before_action :set_line, only: [:show, :edit, :update, :destroy]

  # GET /lines
  def index
    @page = Page.find(params[:page_id])
    @lines = Line.where(page_id: params[:page_id])
  end

  # GET /lines/1
  def show
  end

  # GET /lines/new
  def new
    @page = Page.find(params[:page_id])
    @line = Line.new
  end

  # GET /lines/1/edit
  def edit
    @page = Page.find(params[:page_id])
  end

  # POST /lines
  def create
    @line = Line.new(line_params)
    @page = Page.find(params[:page_id])
    @line.page = @page

    if @line.save
      if @line.items.count == 0
        12.times do |i|
          item = Item.create(line: @line, number: i + 1)
        end
      end
      redirect_to page_lines_url, notice: 'Regel aangemaakt.'
    else
      render :new
    end
  end

  # PATCH/PUT /lines/1
  def update
    if @line.update(line_params)
      if @line.items.count == 0
        num_of_modules = params[:line][:num_of_modules].to_i

        num_of_modules.times do |i|
          item = Item.create(line: @line, number: i + 1)
        end
      end

      redirect_to page_lines_url, notice: 'Line was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /lines/1
  def destroy
    @line.destroy
    redirect_to page_lines_url, notice: 'Line was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line
      @line = Line.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def line_params
      params.require(:line).permit(:number, :num_of_modules, :page_id)
    end
end
