class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes/1
  # GET /recipes/1.json
  def show
    redirect_to recipes_path
  end

  # GET /recipes/new
  def new
    Recipe.delete_all
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe }
        format.json { render :show, status: "Recipe selection saved", location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end


#  # Runs after new or edit, and picks up latest set of food values off recipe record
  def index
    @recipe = Recipe.last

    @page = @recipe.page
    @dish = @recipe.dish
    @ingredients = "#{@recipe.ingredient_1},#{@recipe.ingredient_2},#{@recipe.ingredient_3}"

    @recipes = Recipe.set_of_recipes(@page, @dish, @ingredients)

    unless @recipes[0]
      redirect_to new_recipe_path, notice: 'Selection values did not produce any recipes.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:page, :dish, :ingredient_1, :ingredient_2, :ingredient_3)
    end
end
