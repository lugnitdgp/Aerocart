**To start a Flutter project on your PC, follow these easy steps, even if you're new to it. Here's a simple guide:**

1. **Install Flutter**
    - **Step 1:** Download Flutter from the official [Flutter website](https://flutter.dev/docs/get-started/install).
    - **Step 2:** Extract the downloaded file to a folder on your computer.
    - **Step 3:** Add Flutter to your system’s path:
        - **On Windows:** Search for "Edit the system environment variables," then edit the Path variable and add the path where Flutter is extracted (`flutter/bin` folder).
        - **On macOS/Linux:** Open your terminal and run:
            ```bash
            export PATH="$PATH:`pwd`/flutter/bin"
            ```

2. **Install an Editor (e.g., VS Code)**
    - Download and install [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).
    - Install the Flutter and Dart extensions/plugins inside your editor to support Flutter development.

3. **Set Up Android Studio (for Android Development)**
    - Install Android Studio for the Android development environment.
    - Set up the Android SDK during installation.
    - After setup, open Android Studio > "Configure" > "SDK Manager," and ensure the latest SDKs and tools are installed.
    - Set up an emulator (optional) for testing your apps.

4. **Start a New Flutter Project**
    - Open a terminal (or command prompt) and run:
        ```bash
        flutter create my_first_app
        ```
    - This command creates a new Flutter project in a folder called `my_first_app`.

5. **Navigate to Your Project**
    - In the terminal, go into your project directory:
        ```bash
        cd my_first_app
        ```

6. **Run the App**
    - To run the app, use the following command:
        ```bash
        flutter run
        ```
    - Make sure you either have an Android/iOS emulator running or a physical device connected via USB debugging.

7. Edit Code
        Open the lib/main.dart file in your preferred editor (like VS Code).
        Start editing the default Flutter code to make your own app!
        That’s it! You now have a basic Flutter project set up and ready to go.

Video references-[Linux](https://youtu.be/mtqTnGAAHw0?si=5oLPyoDJUqG0TpQh) ,[Windows](https://youtu.be/bt58doQ_-tQ?si=uwObGhM65iLH2Xi0) 
