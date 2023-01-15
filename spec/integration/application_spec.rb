require 'rspec'
require "spec_helper"
require "rack/test"
require_relative '../../app'


def reset_table
  seed_sql = File.read('spec/seeds/music_library.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_web_test' })
  connection.exec(seed_sql)
end

describe Application do
  before (:each) do
    reset_table
  end

  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

context 'GET /albums' do
  it 'should return the list of albums' do

    response = get('/albums')

    expected_response = 'Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'
    
    expect(response.status).to eq(200)
    expect(response.body).to eq(expected_response)

    end
end

context 'POST /albums' do
it 'should create a new album' do

response = post('/albums', title: 'OK Computer', release_year: '1997', artist_id: '1')

expect(response.status).to eq(200)
expect(response.body).to eq('')

response = get('/albums')
expect(response.body).to include('OK Computer')

end
end


context 'POST /artists' do
  it 'should create a new artist' do
  
  response = post('/artists', name: 'Wild nothing', genre: 'Indie')
  
  expect(response.status).to eq(200)
  expect(response.body).to eq('')
  
  response = get('/artists')
  expect(response.body).to include('Wild nothing')
  
  end
end

  # context 'GET /artists' do
  #   it 'lists all the artists' do
  #
  #     response = get('/artists')
  #     expected_response = ('Pixies, ABBA, Taylor Swift, Nina Simone')
  #     expect(response.status).to eq(200)
  #     expect(response.body).to eq expected_response
  #   end
  # end

  context 'get/' do
    it "it should return an htm code response" do
      response = get('/')
      expect(response.status).to eq(200)
      expect(response.body).to include '<h1>Welcome to my page</h1>'
    end 
  end

  context "it returns album information respective to ID" do
    it 'returns album info with ID of 1' do
      # Assuming the post with id 1 exists.
      response = get('/albums/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end

    it 'returns album info with ID of 2' do
      # Assuming the post with id 1 exists.
      response = get('/albums/2')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('Release year: 1988')
      expect(response.body).to include('Artist: Pixies')
    end

  context 'GET/artists/:id' do
    it 'should return an HTML of an artist with ID 3' do
      response = get('/artists/3')
      expect(response.status).to eq(200)
      repo  = ArtistRepository.new
      artist = repo.find(3)
      expect(artist.id).to eq(3)
      expect(artist.name).to eq('Taylor Swift')
      expect(artist.genre).to eq('Pop')
        end

  context 'GET/artists' do
    it "should return an HTML page with the list of artists with the corresponding artist id." do
    response = get('/artists')
    expect(response.status).to eq(200)
    expect(response.body).to include('<a href="/artists/1">Pixies</a>')
    expect(response.body).to include('<a href="/artists/2">ABBA</a>')
    expect(response.body).to include('<a href="/artists/3">Taylor Swift</a>')
    expect(response.body).to include('<a href="/artists/4">Nina Simone</a>')
        end
      end
    end
  end
end

