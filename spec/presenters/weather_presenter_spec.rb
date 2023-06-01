require "rails_helper"

RSpec.describe WeatherPresenter do

  describe "with weather data" do

  mock_ip_address = Faker::Internet.ip_v4_address

  let(:weather_data) { build(:weather_data) }
  subject(:weather_presenter) { described_class.new(mock_ip_address) }

  before do

    weather_presenter.instance_variable_set(:@weather_data, weather_data)
  end

  describe "#description" do
   specify { expect(weather_presenter.description).to eql(weather_data["current"]["condition"]["text"]) }
  end

  describe "#temperature" do
    specify { expect(weather_presenter.temperature).to eql(weather_data["current"]["temp_c"]) }
  end

  describe "#icon" do
    specify { expect(weather_presenter.icon).to eql(weather_data["current"]["condition"]["icon"]) }
  end

  describe "#location" do
    specify { expect(weather_presenter.location).to eql(weather_data["location"]["name"]) }
  end

  describe "#encourage_text" do

    context 'when weather is nice and temperature is > 15' do
      before do
        weather_data["current"]["condition"]["text"] = "Sunny"
        weather_data["current"]["temp_c"] = 16.0
      end
      specify { expect(weather_presenter.encourage_text).to eql("Get some snacks and go read a book in a park!") }
    end

    context 'when weather is nice but temperature is <= 15' do
      before do
        weather_data["current"]["condition"]["text"] = "Sunny"
        weather_data["current"]["temp_c"] = 15.0
      end
      specify { expect(weather_presenter.encourage_text).to eql("It's always good weather to read a book!") }
    end

    context 'when temperature is > 15 but weather is bad' do
      before do
        weather_data["current"]["condition"]["text"] = "Rainy"
        weather_data["current"]["temp_c"] = 15.5
      end
      specify { expect(weather_presenter.encourage_text).to eql("It's always good weather to read a book!") }
    end

  end
end
end
