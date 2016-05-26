class MoviesController < ApplicationController

  def index
    @movies = Movie.all

    @movies = @movies.search_title("%#{params[:title].upcase}%") if params[:title].present?
    @movies = @movies.search_director("%#{params[:director].upcase}%") if params[:director].present?
    if params[:duration].present?
      case params[:duration].to_i
      when 1
        @movies = @movies.under_90
      when 2
        @movies = @movies.between_90_120
      when 3
        @movies = @movies.over_120
      end
    end

  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])
    @movie.update(movie_params)
    if @movie.save
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
    :title, :release_date, :director, :runtime_in_minutes, :description, :poster_image
    )
  end

end
