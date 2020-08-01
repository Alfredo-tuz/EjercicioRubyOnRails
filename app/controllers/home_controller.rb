class HomeController < ApplicationController
    require 'csv'
    def index
        if params[:notice].present?
            @purchases = Purchase.all
            @total = @purchases.sum { |p| p.product.price * p.quantity }
            puts @total
        else
           @message_error = params[:notice_error]
        end
    end

    def upload
        begin
            file_data = params[:file_tab]
            if file_data.respond_to?(:read)
                xml_contents = file_data.read
                cont = 0
                CSV.parse(xml_contents.strip, :col_sep => '\t') do |row|
                    value_array =row[0].split("\t")
                    if cont >= 1
                        customer = Customer.new(name:value_array[0])#Comprador data cliente 
                        #Descripción del item data producto
                        product = Product.new(description:value_array[1],price:value_array[2])#Precio del item data producto
                        #Name seller 
                        seller = Seller.new(name:value_array[5],direction:value_array[4]) #Direction seller 
                        @purchase = Purchase.new(customer:customer,product:product,seller:seller,quantity:value_array[3]) #Total quantity data purchase
                        @purchase.save!
                    end
                    cont=cont+1
                end
                respond_to do |format|
                    format.html { redirect_to :action=>"index", notice: 'Se ha insertado los registros.' }
                end
            end
        rescue Exception => e # Never do this!
            print e
            respond_to do |format|
                format.html { redirect_to :action=>"index", notice_error: e.message }
            end
        end          
    end
end
