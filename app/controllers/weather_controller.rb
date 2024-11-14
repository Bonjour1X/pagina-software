class WeatherController < ApplicationController
    layout "application"
    def index
        
        @city = 'Santiago,cl'  # Default to Santiago, Chile
        weather_service = WeatherService.new
        @forecast = weather_service.forecast(@city)
        @dia0 = @forecast["forecast"]["forecastday"][0]
        @dia0_date = Date.today.strftime("%A, %d %B %Y")
        @tomorrow_forecast = @forecast["forecast"]["forecastday"][1]
        @tomorrow_date = Date.tomorrow.strftime("%A, %d %B %Y")
        @dia2 = @forecast["forecast"]["forecastday"][2]
        @dia2_date = (Date.tomorrow+1).strftime("%A, %d %B %Y")
        @dia3 = @forecast["forecast"]["forecastday"][3]
        @dia3_date = (Date.tomorrow+2).strftime("%A, %d %B %Y")
        @dia4 = @forecast["forecast"]["forecastday"][4]
        @dia4_date = (Date.tomorrow+3).strftime("%A, %d %B %Y")
        @dia5 = @forecast["forecast"]["forecastday"][5]
        @dia5_date = (Date.tomorrow+4).strftime("%A, %d %B %Y")
        @dia6 = @forecast["forecast"]["forecastday"][6]
        @dia6_date = (Date.tomorrow+5).strftime("%A, %d %B %Y")
        @dia7 = @forecast["forecast"]["forecastday"][7]
        @dia7_date = (Date.tomorrow+6).strftime("%A, %d %B %Y")
        render layout: "application"
    end
    def initialize
        @api_key = 'eff79d938fd54a50812142559241411'
        @base_url = 'http://api.weatherapi.com/v1/forecast.json'
      end
  end
  