class Admin::ItemDetailsController < ApplicationController
  before_action :set_item_detail, only: [:show, :edit, :update, :destroy]

  # GET /item_details
  def index
    @item_details = ItemDetail.all
  end

  # GET /item_details/1
  def show
  end

  # GET /item_details/new
  def new
    @item_detail = ItemDetail.new
  end

  # GET /item_details/1/edit
  def edit
  end

  # POST /item_details
  def create
    @item_detail = ItemDetail.new(item_detail_params)

    if @item_detail.save
      redirect_to admin_item_detail_path(@item_detail), notice: 'Item detail was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /item_details/1
  def update
    if @item_detail.update(item_detail_params)
      redirect_to admin_item_detail_path(@item_detail), notice: 'Item detail was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /item_details/1
  def destroy
    @item_detail.destroy
    redirect_to admin_item_details_url, notice: 'Item detail was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item_detail
      @item_detail = ItemDetail.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_detail_params
      params.require(:item_detail).permit(:name)
    end
end
