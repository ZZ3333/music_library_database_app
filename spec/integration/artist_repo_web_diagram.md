```mermaid
sequenceDiagram
  participant C as Client
  participant S as Sinatra Application
  participant R as Repository Class
  participant D as Database
  C->>+S: Forwards HTTP request POST /artists, address is http://localhost:9292, path is /artists route block
  rect rgb(400, 350, 355)
  S->>R: Calls the GET request, and executes the route block, which calls the method ArtistRepository#all
  R->>D: The ArtistRepository#all class runs a SQL query to the database music_library_web_test.
  A->>R: Sends response “Alice,Joe,Julia,Kieran,Zoe”
  end
  D->>R: The music_library_web_test database returns an HTTP Response, “it returns response.status and response.body as ordered list of names” “Pixies, ABBA, Taylor Swift, Nina Simone”
  R->>S: The Repository class returns a list of Artist objects to the route block.
  S->>C: The route block sends a response to the client containing the data.
```



-- 1 The client sends a HTTP request to the web server over the Internet: GET /albums
-- 2 The web server (a Sinatra application, in our case) handles the request, and executes the route block, which calls the method AlbumRepository#all
-- 3 The Repository class runs a SQL query to the database.
-- 4 The database returns a result set to the program.
-- 5 The Repository class returns a list of Album objects to the route block.
-- 6 The route block sends a response to the client containing the data.
-- 7 The flow described above is what most CRUD web applications will implement, so it is important to get familiar with it, and to have a good mental model on how it works.