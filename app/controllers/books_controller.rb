class BooksController < ApplicationController
  def new
    @book = Book.new
    @user = current_user
    @books = @user.books.all
  end
  
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
   if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to "/books/#{@book.id}"
   else
    @user = current_user
    @books = Book.all
    render :new
   end  
  end

  def index
    @book = Book.new
    @books = Book.all
    @user = current_user
  end

  def show
     @book = Book.new
     @books = Book.find(params[:id])
     @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
   if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to "/books/#{@book.id}"  
   else
     render :edit
   end 
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to "/books"  
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end  
  
end
