class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all 
      flash.now[:notice] = "Book was not successfully created"  
      render :index
    end
    
  end

  def index
    @user=User.all
    @books = Book.all
    @book =Book.new
  end

  def show
    @books=Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @post_comment = PostComment.new
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end

  def update
    is_matching_login_user
    @book = Book.find(params[:id])
    if  @book.update(book_params)
      flash[:notice] = "Book was successfully updated"
      redirect_to book_path(@book.id) 
    else 
      flash.now[:notice] = "Book was not successfully updated"
      render :edit
    end
  end

  def destroy 
    is_matching_login_user
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user == current_user
      redirect_to books_path
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
 
end
