class RequestsController < ApplicationController
  before_action :set_request, only: [ :show, :edit, :update, :destroy ]
  before_action :set_book,    only: [ :index, :new, :create ]

  # GET /requests
  # GET /requests.json
  def index
    @book_requests = Request
        .where(search_params)
        .order(:should_return_on, :borrowed_on)

    if scope = params[:scope]
      @book_requests = @book_requests.send scope
    end

    # TODO: add pagination
  end

  # GET /requests/1
  # GET /requests/1.json
  def show
  end

  # GET /requests/new
  def new
    @book_request = Request.new book_id: params[:book_id]
  end

  # GET /requests/1/edit
  def edit
  end

  # POST /requests
  # POST /requests.json
  def create
    @book_request = @book.requests.build request_params_for_create

    respond_to do |format|
      if @book_request.save
        format.html { redirect_to @book_request, notice: 'Request was successfully created.' }
        format.json { render :show, status: :created, location: @book_request }
      else
        format.html { render :new }
        format.json { render json: @book_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requests/1
  # PATCH/PUT /requests/1.json
  def update
    respond_to do |format|
      if @book_request.update request_params_for_update
        format.html { redirect_to @book_request, notice: 'Request was successfully updated.' }
        format.json { render :show, status: :ok, location: @book_request }
      else
        format.html { render :edit }
        format.json { render json: @book_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.json
  def destroy
    @book_request.destroy
    respond_to do |format|
      format.html { redirect_to requests_url, notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_request
    @book_request = Request.find params[:id]
  end

  def set_book
    if book_id = params[:book_id]
      @book = Book.find book_id
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def request_params_for_create
    params.require(:request).permit :borrower, :borrowed_on, :should_return_on
  end

  def request_params_for_update
    params.require(:request).permit :returned_on
  end

  def search_params
    params.permit :book_id, :borrower, :borrowed_on, :should_return_on, :returned_on
  end
end
