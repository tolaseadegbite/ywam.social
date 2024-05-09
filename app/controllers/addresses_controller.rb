class AddressesController < ApplicationController
    before_action :authenticate_account!
    before_action :find_address, only: [:show, :edit, :update, :destroy]

    def index
      @addresses = current_account.addresses
    end

    def new
      @address = Address.new address_params
    end

    def show
      
    end

    def create
      @address = current_account.addresses.build(address_params)
        if @address.save
            respond_to do |format|
                format.html {redirect_to account_address_url(current_account, @address), notice: "Address created successfully!"}
            end
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
      
    end

    def update
        if @address.update(address_params)
            respond_to do |format|
                format.html {redirect_to account_address_url(current_account, @address), notice: "Address updated successfully!"}
            end
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @address.destroy
        respond_to do |format|
            format.html {redirect_to addresses_url, notice: "Address deleted successfully!"}
        end
    end

    private

        def address_params
          params.fetch(:address, {}).permit(:country, :state, :city)
        end

        def find_address
            @address = current_account.addresses.find(params[:id])
        end
end
