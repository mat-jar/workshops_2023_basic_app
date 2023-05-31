require "rails_helper"

RSpec.describe WeatherPresenter do

  mock_ip_address = Faker::Internet.ip_v4_address
  mock_weather_data = { "location" => {"name" => Faker::Address.city},
                        "current" => {"temp_c" => Faker::Number.decimal(l_digits: 2),
                                     "condition" => {"text" => Faker::Adjective.positive ,
                                                    "icon" => Faker::File.file_name}
                                                    }
                                                        }

  subject(:weather_presenter) { described_class.new(mock_ip_address) }

  before do
    weather_presenter.instance_variable_set(:@weather_data, mock_weather_data)
  end

  describe "#description" do
   specify { expect(weather_presenter.description).to eql(mock_weather_data["current"]["condition"]["text"]) }
  end

  describe "#temperature" do
    specify { expect(weather_presenter.temperature).to eql(mock_weather_data["current"]["temp_c"]) }
  end

  describe "#icon" do
    specify { expect(weather_presenter.icon).to eql(mock_weather_data["current"]["condition"]["icon"]) }
  end

  describe "#location" do
    specify { expect(weather_presenter.location).to eql(mock_weather_data["location"]["name"]) }
  end

  describe "#encourage_text" do

    context 'when weather is nice and temperature is > 15' do
      before do
        mock_weather_data["current"]["condition"]["text"] = "Sunny"
        mock_weather_data["current"]["temp_c"] = 16.0
      end
      specify { expect(weather_presenter.encourage_text).to eql("Get some snacks and go read a book in a park!") }
    end

    context 'when weather is nice but temperature is <= 15' do
      before do
        mock_weather_data["current"]["condition"]["text"] = "Sunny"
        mock_weather_data["current"]["temp_c"] = 15.0
      end
      specify { expect(weather_presenter.encourage_text).to eql("It's always good weather to read a book!") }
    end

    context 'when temperature is > 15 but weather is bad' do
      before do
        mock_weather_data["current"]["condition"]["text"] = "Rainy"
        mock_weather_data["current"]["temp_c"] = 15.5
      end
      specify { expect(weather_presenter.encourage_text).to eql("It's always good weather to read a book!") }
    end

  end

end
