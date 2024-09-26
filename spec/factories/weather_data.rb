FactoryBot.define do
  factory :weather_data, class: Hash do
    skip_create
    location {{"name" => Faker::Address.city }}
    current {{"temp_c" => Faker::Number.decimal(l_digits: 2),
              "condition" => {"text" => Faker::Adjective.positive ,
                                "icon" => Faker::File.file_name}
                                }}
    initialize_with { attributes.stringify_keys }
  end
end
