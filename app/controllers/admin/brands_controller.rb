module Admin
  class BrandsController < BaseController
    def index
      @brands = Brand.all
    end

    def new
      @brand = Brand.new
    end

    def create
      @brand = Brand.new(brand_params)

      if @brand.save
        redirect_to admin_brands_path, notice: t('admin.brands.create.success')
      else
        render :new
      end
    end

    def edit
      @brand = Brand.find(params[:id])
    end

    def update
      @brand = Brand.find(params[:id])

      if @brand.update(brand_params)
        redirect_to admin_brands_path, notice: t('admin.brands.update.success')
      else
        render :edit
      end
    end

    def destroy
      @brand = Brand.find(params[:id])

      # Check if there are gears associated with the brand
      if @brand.gears.any?
        redirect_to admin_brands_path, alert: t('admin.brands.destroy.has_gears_warning')
      else
        @brand.destroy
        redirect_to admin_brands_path, notice: t('admin.brands.destroy.success')
      end
    end

    private

    def brand_params
      params.require(:brand).permit(:name)
    end
  end
end
