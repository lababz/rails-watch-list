class ListsController < ApplicationController
  before_action :set_list, only: [:show, :destroy]
  before_action :set_lists, only: [:index, :create, :destroy]

  def index
    @list = List.new
  end

  def show
    @bookmark = Bookmark.new
    @review = Review.new(list: @list)
  end

  def new # GET
    @list = List.new
  end

  def create # POST
    @list = List.new(list_params)
    if @list.save
      redirect_to @list, notice: "✅ list was successfully created."
    else
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @list.destroy
    redirect_to lists_path, status: :see_other
  end

  private

  def list_params
    params.require(:list).permit(:name, :photo)
  end

  def set_list
    @list = List.find(params[:id])
  end

  def set_lists
    @lists = List.all
  end
end
