
# Flutter Task Posting and Application App with Firebase

This Flutter app project is intended to be a comprehensive platform where users can post various tasks and jobs, allowing random users in their nearby area to apply for these tasks. The app is designed to support a wide range of tasks, from one-time jobs like taking a job poster's mobile device to a repair shop and returning it after repair to regular tasks such as hiring maids or drivers.

Note: This project is currently unfinished and is in a partial state of development. It lacks certain features and may contain bugs or incomplete functionality.

The primary functionalities intended for this app include user registration and authentication, task posting with relevant details like description, location, and budget, task discovery based on user preferences, task application by interested users, real-time chat for task communication, task management for both task posters and applicants, ratings and reviews for completed tasks, user profiles, and integration of geolocation and maps for easy task navigation.

Important: As this project is incomplete, it may require additional development, debugging, and optimization to be fully functional and deployable. Contributions and improvements from the open-source community are welcome to help bring this project to completion.

By providing a platform that promotes local community engagement, this app aims to connect individuals seeking assistance with various tasks and those willing to offer their skills and services. Users can leverage the app to find help for their tasks and contribute back to their community by assisting others, making it a valuable tool for task management and fostering a sense of collaboration and support among users.


## Features

User Registration and Authentication:
Users can create accounts or log in using their credentials to access the app's features.

Task Posting:
Authenticated users can post tasks they need assistance with, providing essential details such as task type, description, location, and budget.

Task Discovery:
Users can explore a feed of tasks available for application

Task Application:
Only registered and authenticated users can apply for tasks they are willing to take up. The task posters will receive notifications when someone applies for their task.

Task Management:
Task posters can view and manage applications they receive for their posted tasks.
Users can track the status of their applied tasks.

Search for Job:
A jobber can search for job with its name or skills he want to do job in.

## Features To Add

Real-time Chat:
A built-in chat system allows users to communicate with each other to discuss task details and arrangements.

Ratings and Reviews:
Users can rate and review each other after completing a task, providing valuable feedback to build a trustworthy community.

User Profiles:
Users can view and update their profiles, including personal information, task history, and ratings.

Geolocation and Maps Integration:
The app utilizes geolocation services to identify nearby tasks and display them on a map for easy navigation.

Notifications:
Users receive real-time notifications for task applications, task updates, and other relevant events.

Submit Docs:
An individual seeking to do a jobs needs to first register by sending relevant docs and only after confirming he can apply for the job.

Skills List:
Options for various skills like driver, painter, carpenter etc.. should be provided and these skilled workers needs to first prove their skills to get registered and apply for the job and also.

## Deployment

To deploy this project

**ADD YOU FIREBASE CONFIGS IN MAIN.DART **

**ADD GOOGLE SERVICES JSON FILE IN ADROID/SRC**

```
flutter pub get
flutter run //To run the project default output settings
flutter run -d chrome --web-renderer html //To run the project on the web, and with html so that the images load
```
## Demo

**Authentication**
![Screenshot_2023-07-21-11-46-17-784_com example jobby](https://github.com/rayy2002/Flutter-Task-Posting-and-Application-App/assets/88958861/0043b4db-9b3b-413f-becf-21b76ca43ddf)
![Screenshot_2023-07-21-11-45-43-231_com example jobby](https://github.com/rayy2002/Flutter-Task-Posting-and-Application-App/assets/88958861/5c43cfe0-5581-4b15-8640-6b33f42f1e17)
![Screenshot_2023-07-21-11-45-21-286_com example jobby](https://github.com/rayy2002/Flutter-Task-Posting-and-Application-App/assets/88958861/66f95dfc-9a69-460c-b5e3-a3912c73b6f0)


