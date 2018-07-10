class Pokemon <ActiveRecord::Base
  has_many :encounters

def get_api
  pokemon_api = RestClient.get("http://pokeapi.co/api/v2/pokemon/#{self.pokedex_id}")
end

def parse_api(pokemon_api)
  JSON.parse(pokemon_api.body)
end

def display_name
  parse_api(get_api)["name"].titleize
end

def display_id
  parse_api(get_api)["id"]
end

end