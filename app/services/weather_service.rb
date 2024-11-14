class WeatherService
    include HTTParty
    base_uri 'http://api.weatherapi.com/v1'
  
    def initialize
      @api_key = ENV['WEATHER_API_KEY'] # O usa Rails.application.secrets.weather_api_key
    end
  
    def forecast(city)
      self.class.get("/forecast.json?key=#{@api_key}&q=#{city}&days=8")
    end
  end
  