# News App

## Overview
This is a Flutter-based News App that fetches and displays news articles using the News API. The app features image caching, pagination, and optimized performance for handling large datasets efficiently.

## Features
- **Splash Screen:** Displays for at least 1 second before navigating to the listing screen.
- **Listing Screen:** Fetches and displays news articles in a grid layout with images.
- **Expanded Screen:** Displays the selected news article image in full screen with pinch-to-zoom support.
- **Optimized for Large Data Handling:** Efficiently manages millions of records with images using caching and lazy loading.
- **API Integration:** Uses Dio for network requests.
- **Caching:** Uses Hive for storing API responses and image caching.
- **Memory Optimization:** Loads and processes only the required images to reduce memory usage.
- **Pagination:** Loads data in chunks instead of fetching everything at once.
- **Unit & Widget Testing:** Includes test cases to ensure the functionality of the app.

## Setup & Installation
### Prerequisites
- Flutter SDK installed
- VS Code
- API key from [The News API](https://www.thenewsapi.com/)

