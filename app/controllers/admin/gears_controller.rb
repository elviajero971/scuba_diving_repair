module Admin
  class GearsController < BaseController
    def index
      @gears = Gear.includes(:brand).all
    end

    def new
      @gear = Gear.new
      @brands = Brand.all
    end

    def create
      @gear = Gear.new(gear_params)

      if @gear.save
        redirect_to admin_gears_path, notice: t('admin.gears.create.success')
      else
        @brands = Brand.all
        render :new
      end
    end

    def edit
      @gear = Gear.find(params[:id])
      @brands = Brand.all
    end

    def update
      @gear = Gear.find(params[:id])

      if @gear.update(gear_params)
        redirect_to admin_gears_path, notice: t('admin.gears.update.success')
      else
        @brands = Brand.all
        render :edit
      end
    end

    def destroy
      @gear = Gear.find(params[:id])

      # Check if there are services associated with this gear
      if @gear.services.any?
        redirect_to admin_gears_path, alert: t('admin.gears.destroy.has_services_warning')
      else
        @gear.destroy
        redirect_to admin_gears_path, notice: t('admin.gears.destroy.success')
      end
    end

    private

    def gear_params
      params.require(:gear).permit(:name, :gear_type, :brand_id)
    end
  end
end
