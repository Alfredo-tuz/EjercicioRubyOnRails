class HomeController < ApplicationController
    #Esta clase proporciona una interfaz completa para archivos y datos CSV .
    #Ofrece herramientas que le permiten leer y escribir desde y hacia Strings u objetos IO, según sea necesario.
    require 'csv'

    #Index GET HOME
    #si se encuentra el parametro notice es que en el metodo save_data 
    #guardo satisfactoriamente
    #y se visualizará el total de ingresos que se hizo
    #error: si no se guarda bien manda el parametro notice_error 
    #y se visualiza el error en inde
    def index
        if params[:notice].present?
            @purchases = Purchase.all
            @total = @purchases.sum { |p| p.product.price * p.quantity }
            puts @total
        else
           @message_error = params[:notice_error]
        end
    end

    #Se guarda el data usando parse de la clase CSV
    def save_data
        begin
            file_data = params[:file_tab]
            if file_data.respond_to?(:read)
                xml_contents = file_data.read #data string
                #tenemos un contador ya que el primero registro es el header del archivo
                cont = 0
                CSV.parse(xml_contents.strip, :col_sep => '\t') do |row|
                    value_array =row[0].split("\t")
                    if cont >= 1
                        customer = Customer.new(name:value_array[0])#Comprador data cliente 
                        #valida el modelo sus validaciones
                        customer.save!
                        #Descripción del item data producto
                        product = Product.new(description:value_array[1],price:value_array[2])#Precio del item data producto
                        #valida el modelo sus validaciones
                        product.save!
                        #Name seller 
                        
                        seller = Seller.new(name:value_array[5],direction:value_array[4]) #Direction seller 
                        #valida el modelo sus validaciones
                        seller.save

                        @purchase = Purchase.new(customer:customer,product:product,seller:seller,quantity:value_array[3]) #Total quantity data purchase
                        #valida el modelo sus validaciones
                        @purchase.save!
                    end
                    cont=cont+1
                end
                respond_to do |format|
                    format.html { redirect_to :action=>"index", notice: 'Se ha insertado los registros.' }
                end
            end
        rescue Exception => e # Captura el error y manda el mensaje de error!
            print e
            respond_to do |format|
                format.html { redirect_to :action=>"index", notice_error: e.message }
            end
        end          
    end
end
