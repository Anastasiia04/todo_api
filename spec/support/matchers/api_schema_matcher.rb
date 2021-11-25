RSpec::Matchers.define :match_response_schema do |schema|
  match do |response|
    schema = Pathname.new("#{Dir.pwd}/spec/support/schemas/#{schema}.json")
    schemer = JSONSchemer.schema(schema)
    schemer.valid?(JSON.parse(response.body))
  end
end
