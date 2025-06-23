class HomeController < ApplicationController
    def index
        # render html: "<h1>Hello, World!</h1>".html_safe

        message="<h1>Hello, World!</h1>"
        message+="<p>This is a paragraph</p>"
        message+="<a href='https://www.google.com'>Google</a>"
        message+="<img src='https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png' alt='Google Logo'>"
        render html: message.html_safe
    end
    def getquery
        message = ""
        @query=params[:query]
        message+="<h1>You searched for: #{@query}</h1>"

        message+= "<h1>Controller name is #{params[:controller]}</h1>"
        # message+= "<h1>Controller name is #{self.class.name}</h1>"
        message+= "<h1>Action name is #{params[:action]}</h1>"
        render html: message.html_safe
    end

    def passdatatoviews
        @message="Hello, World!"
        @number=123
        @array=[ 1, 2, 3, 4, 5 ]
        @hash={ "name"=>"John", "age"=>30 }
        @boolean=true
        @nil=nil
        render "passdatatoviews"
    end
end
