# Movie Recommendation App

The **Movie Recommendation App** is a Flutter application that helps users discover popular movies and filter them by genre. It utilizes the TMDb API to fetch real-time movie data and display it in an intuitive interface. This app allows users to browse movies by genres and view detailed information for each movie.

## Features

- **Browse Popular Movies**: Users can explore a list of popular movies fetched from the TMDb API.
- **Filter by Genre**: Users can filter movies based on their preferred genre using a dropdown menu.
- **Movie Details**: Upon selecting a movie, users can view detailed information such as the title, description, and a movie poster.
- **Dynamic Movie Data**: The app fetches real-time data from the TMDb API, ensuring that users always see the latest popular movies and genres.

### Installation

- Clone the repository:
  ``` bash
  git clone https://github.com/your-username/movie-recommendation-app.git
  ```
- Install dependencies:
  ```
  flutter pub get
  ```
- Run the app on an emulator or a physical device: </br >
  ```
  flutter run
  ```

### API Integration

This app uses The Movie Database (TMDb) API to fetch movie data. To run the app, you will need to create an account on TMDb, generate an API key, and add it to the api_service.dart file.

### How It Works
- API Service: The ApiService class handles all API requests. It includes methods to fetch genres and popular movies from TMDb.
- FutureBuilder: The app uses FutureBuilder widgets in the screens to handle asynchronous requests to the API. These widgets ensure the UI reacts accordingly while waiting for data or handling errors.
- UI Components: The app is built using reusable components such as MovieCard and MovieList, making it easy to display the fetched movie data in a clean and modular way.

