class ListsController < ApplicationController
  before_action :set_list, only: :show # [:show, :destroy]

  def index
    @lists = List.all
  end

  def show
    @bookmark = Bookmark.new
  end

  def new # GET
    @list = List.new
  end

  def create # POST
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: "✅ list was successfully created." # redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name)
  end

  def set_list
    @list = List.find(params[:id])
  end
end
