class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  def index
    @items = Item.where(line_id: params[:line_id]).order_by(number: :asc)
  end

  # GET /items/1
  def show

  end

  # GET /items/new
  def new
    @item = Item.new
    @line = Line.find(params[:line_id])
  end

  # GET /items/1/edit
  def edit

  end

  # POST /items
  def create
    @line = Line.find(params[:line_id])
    @item = Item.new(item_params)
    @item.line = @line

    if @item.save
      redirect_to page_line_items_url, notice: 'Module aangemaakt.'
    else
      render :new
    end
  end

  # PATCH/PUT /items/1
  def update
    @index = @line.items.index(@item)
    @num_of_modules = @line.num_of_modules



    if @item.update(item_params)

      redirect_to page_line_items_url, notice: 'Module gewijzigd.'
    else
      render :edit
    end
  end

  # DELETE /items/1
  def destroy
    @item.destroy

    # num_of_modules = @line.num_of_modules
    #
    # if num_of_modules < 12
    #   diff = 12 - num_of_modules
    #
    #   num = [1,2,3,4,5,6,7,8,9,10,11,12] - @line.items.select.pluck(:number)
    #
    #   diff.times do
    #     item = Item.create(line: @line, number: num[0], title: "")
    #   end
    # end

    redirect_to page_line_items_url, notice: 'Module verwijderd.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @page = Page.find(params[:page_id])
      @line = Line.find(params[:line_id])
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:title, :number, :modulen, :line, :description)
    end
end
