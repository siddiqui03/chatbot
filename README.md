# Zozo Chatbot

Zozo is a Flutter-based chatbot application that leverages the Gemini API for generating chatbot responses. This app features an introductory page and a chat interface where users can interact with Zozo, the chatbot. Users can also send images to the chatbot for description.

## Features

- Interactive chat interface with Gemini-based responses.
- Image upload capability for image description.
- Introductory page with navigation to the chat interface.
- Customizable and responsive UI.

## Project Structure

- `lib/`
  - `home.dart` - Contains the main chat interface where users interact with Zozo.
  - `intro.dart` - Introductory page that navigates to the main chat interface.
  - `consts.dart` - Contains constants and API keys (this file is excluded for security).
- `assets/`
  - `gif/chatbot.gif` - Introductory GIF image.
  - `images/chatbot.png` - Profile image for the chatbot.

## Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/yourusername/yourrepository.git
   cd yourrepository
   ```

2. **Install Dependencies**

   Make sure you have Flutter installed. Then, run:

   ```bash
   flutter pub get
   ```

3. **Run the App**

   To run the app on an emulator or a connected device, use:

   ```bash
   flutter run
   ```

## Usage

- **Intro Page**: Launches when the app starts, displaying an introductory GIF and a button to proceed to the chat interface.
- **Chat Interface**: Allows users to interact with Zozo, send messages, and upload images. Zozo responds based on the input and describes uploaded images.
