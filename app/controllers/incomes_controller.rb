class IncomesController < ApplicationController
	before_action :set_mybudget
	before_action :set_income, only: [:show, :edit, :update, :destroy]

def index
  @incomes = @mybudget.incomes.all
end

def new
	@income = @mybudget.incomes.build
end

def edit
end

def create
	 @income = @mybudget.incomes.build(income_params)

	respond_to do |format|
    if @income.save
        format.html { redirect_to [@mybudget, @incomes], notice: 'income was successfully created.' }
        format.json { render :show, status: :created, location: @income }
        format.js {redirect_via_turbolinks_to [@mybudget, @incomes]}
      else
        format.html { render :new }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
end

def update
	respond_to do |format|
    	if @income.update(income_params)
	  	  format.html { redirect_to edit_income_path(@income)}
        format.json { render :show, status: :ok, location: @income }
        format.js {redirect_via_turbolinks_to [@mybudget, @incomes]}
      else
        format.html { render :edit }
        format.json { render json: @income.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @income.destroy
    respond_to do |format|
      format.html { redirect_to mybudget_incomes_path(@mybudget), notice: 'user was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_mybudget
      @mybudget = Mybudget.find(params[:mybudget_id])
    end

    def set_income
      @income = Income.find(params[:id])
  	end

  	def income_params
      params.require(:income).permit(:income, :amount)
    end
end