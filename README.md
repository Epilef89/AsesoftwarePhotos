# AsesoftwarePhotos
## Overview

Asesoftware needs to list a series of photographs and obtain the details of each one of them. Therefore, an app needs to be developed that, once it obtains the list from the external service, saves this information locally, so that it can be accessed when the application does not have a connection to the service.

## Features

- Splash screen upon app launch.
- Screen for listing images fetched from the GET service: [https://jsonplaceholder.typicode.com/photos](https://jsonplaceholder.typicode.com/photos).
- Ability for the user to select an item from the list and navigate to a detail screen for that particular item.
- Implementation of a button on the photo detail screen to delete the photo and call the DELETE service: [https://jsonplaceholder.typicode.com/photos/1](https://jsonplaceholder.typicode.com/photos/1).
- If the application is offline, it should save this operation in memory and, once it regains connection with the service, it should retry the call to confirm the deletion of the record.
- Utilization of Core Data for persisting data locally.
- Asynchronous processes for downloading images.
- Unit tests covering the architecture's integration and the Presenter and Interactor functionalities. No tests are performed on the Router and ViewController intentionally.
  
  **Note:** The Router and ViewController are not directly responsible for business logic or data manipulation. The Router's primary responsibility is navigation between screens, which can be tested effectively through UI testing. The ViewController's responsibility is to manage the view and user interactions, which are more suitable for UI testing rather than unit testing. By focusing unit tests on the business logic and data manipulation layers, we ensure a more comprehensive and efficient testing strategy.


## Architecture

The project follows the VIPER architecture pattern, which stands for View, Interactor, Presenter, Entity, and Router. This architecture provides a clear separation of concerns and promotes testability and maintainability.

## Classes Relationship

- **View**: Responsible for presenting the user interface and handling user interactions.
- **Interactor**: Contains the business logic and interacts with data sources to fetch and manipulate data.
- **Presenter**: Mediates between the view and the interactor, formatting data from the interactor for display in the view.
- **Entity**: Represents the data model used by the application.
- **Router**: Handles navigation between different screens or modules within the application.

## Installation

1. Clone the repository.
2. Open the project in Xcode.
3. **From Xcode:**
   - Go to File > Swift Packages > Resolve Package Versions.
   - This will trigger Xcode to resolve and download any missing dependencies using Swift Package Manager (SPM).
   
   **From the console:**
   - Navigate to your project's root directory in Terminal.
   - Run the following command to update dependencies using Swift Package Manager (SPM):
     ```
     swift package resolve
     ```
   - This will download and resolve any missing dependencies.
   
4. Build and run the project on a simulator or device.

## Dependencies

- [SDWebImage](https://github.com/SDWebImage/SDWebImage): Library for asynchronous image loading and caching.
- [PureLayout](https://github.com/PureLayout/PureLayout): Provides a simple and easy-to-use API for creating Auto Layout constraints programmatically.
- [Lottie](https://github.com/airbnb/lottie-ios): Library for seamlessly adding high-quality animations to any native app.

## Usage

1. Launch the app.
2. View the splash screen.
3. Navigate to the image listing screen.
4. Select an image to view its details.
5. On the detail screen, you can delete the image.

## Running Unit Tests

1. Open the Xcode project.
2. Navigate to the project navigator.
3. Select the target containing the unit tests.
4. Go to Product > Test or use the shortcut ⌘U.
5. Xcode will compile the project and execute the unit tests.
6. View the test results in the Xcode test navigator or the console output.
