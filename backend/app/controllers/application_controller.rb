class ApplicationController < ActionController::API
    def food_cal(query)
        require 'net/http'
        require 'uri'

        api_url = "https://api.api-ninjas.com/v1/nutrition?query=#{CGI.escape(query)}"
        uri = URI.parse(api_url)
        request = Net::HTTP::Get.new(uri)
        request['X-Api-Key'] = 'jv0VxLujC1De2xvBzLesnQ==Bj7A0pKc0tunOSpL'

        response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
        end

        if response.code == '200'
        
            data = JSON.parse(response.body)
            puts data
            
            return data
        end
    end

    def cal_track(age=21, gender='male',height=175, weight=65, activity_level ='level_1')
        require 'uri'
        require 'net/http'
        require 'openssl'

        # Example variable values
        age = age
        gender = gender
        height = height
        weight = weight
        activity_level = activity_level

        # Create the URI object with the base URL and query parameters
        url = URI("https://fitness-calculator.p.rapidapi.com/dailycalorie")
        url.query = URI.encode_www_form({
        "age" => age,
        "gender" => gender,
        "height" => height,
        "weight" => weight,
        "activitylevel" => activity_level
        })

        # Create the HTTP request
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(url)
        request["X-RapidAPI-Key"] = 'a9201729eemshbe294abaa71612fp100ea9jsne9f64f9f28c8'
        request["X-RapidAPI-Host"] = 'fitness-calculator.p.rapidapi.com'

        # Make the request and print the response body
        response = http.request(request)
        if response.code == '200'
        
            data = JSON.parse(response.read_body)
            # puts data
            return data
        end

    end

    def imageSearch(fileName) 
        require "net/https"
        require "uri"
        puts "--------------------"
        puts fileName
        puts "---------------------"
        puts "************************"

        uri = URI.parse("https://api.logmeal.es/v2/recognition/dish")
        form = [["image", File.open("C://Users//asus//Desktop//Project//New folder//majorProject//backend//public//uploads//#{fileName}")]]

        req = Net::HTTP::Post.new(uri)
        req["Authorization"] = "Bearer 85094a1e5159053693f063543eb3c1e30b690c15"
        req.set_form form, "multipart/form-data"

        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
            http.request(req)
        end
        if res.code == '200'
        
            data = JSON.parse(res.body)
            # food_d["model_versions"]["recognition_results"][0]["name"]
        end

        puts res.body
        puts data
        query = data["recognition_results"][0]["name"]
        data = food_cal(query)
        return data

    end
end
