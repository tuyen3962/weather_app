# Weather app

## Project Structure
Below is an overview of the key directories and files in this project:

## Framework
Flutter - version 3.27.1

## Architectural
- **`.base/`**: this folder 
- **`.constant/`**: Store the default variable for global use
- **`.model/`**: This folder contains the data models used throughout the application
- **`.repository/`**: Handle call API and convert data from API to specific model
- **`.screen/`**: The main UI screen of this application
- **`.service/`**: This folder contains the service classes responsible for handling business logic and interacting with external APIs or data sources. These services act as intermediaries between the repository layer and the UI, ensuring a clean separation of concerns.
- **`.widget/`**: Store the view which can be reused in multiple screens or layouts

## Libraries
The following libraries are used in this project to enhance functionality and simplify development:

### Dependencies
- **`connectivity_plus`**: Provides network connectivity status and allows monitoring of changes in connectivity (e.g., Wi-Fi, mobile data).
- **`dio`**: A powerful HTTP client for Dart, used for making API requests with advanced features like interceptors, request cancellation, and more.
- **`equatable`**: Simplifies equality comparisons for Dart objects, making it easier to compare instances of classes.
- **`flutter_bloc`**: Implements the BLoC (Business Logic Component) pattern, enabling state management and separation of concerns in the app.
- **`geolocator`**: Provides geolocation functionality, such as retrieving the user's current location and monitoring location changes.
- **`get_it`**: A simple service locator for dependency injection, used to manage and access services throughout the app.
- **`injectable`**: Works with `get_it` to generate boilerplate code for dependency injection, making it easier to manage dependencies.
- **`intl`**: Supports internationalization and localization, including formatting dates, numbers, and currencies.
- **`json_annotation`**: Provides annotations for JSON serialization and deserialization, used with `json_serializable` to generate boilerplate code.

### Dev Dependencies
- **`flutter_test`**: Provides a framework for writing unit and widget tests for Flutter applications.
- **`flutter_lints`**: A set of recommended linter rules for Flutter projects to ensure code quality and consistency.
- **`injectable_generator`**: Generates code for dependency injection using `injectable` and `get_it`.
- **`json_serializable`**: Generates code for JSON serialization and deserialization based on `json_annotation`.
- **`build_runner`**: A tool for generating code (e.g., for `json_serializable` and `injectable`) during development.

## Getting Started
To get started with the Weather App, follow these steps:

1. **Clone the repository**:
   ```sh
   git clone <repository-url>
   cd weather_app

