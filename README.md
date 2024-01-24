# Blog Task

### Project Description

This Blog Application is a modern web platform designed to provide a comprehensive blogging experience. It features a RESTful API that supports:

- **User Authentication**: Secure login and signup functionalities.
- **CRUD Operations for Posts**: Users can create, read, update, and delete blog posts. Each post includes details like title, body, author, tags, and comments.
- **Automated Post Deletion**: Posts are automatically deleted 24 hours after creation, utilizing Sidekiq and Redis.
- **Robust Commenting System**: Users can comment on posts and manage their comments.

The backend is developed using Ruby on Rails, with PostgreSQL as the database. The application's background tasks, such as scheduled post deletions, are handled by Sidekiq with Redis as the broker. The entire application is containerized with Docker, ensuring seamless deployment and scalability.

## API Endpoints

A brief overview of each API endpoint in the application:

### Users
- `POST /api/v1/users`: Create a new user.
- `GET /api/v1/users/:id`: Retrieve a specific user's details.
- `PUT /api/v1/users/:id`: Update a user's information.
- `DELETE /api/v1/users/:id`: Delete a user.

### Posts
- `GET /api/v1/posts`: List all posts with pagination, sorting, filtering, and search capabilities.
- `GET /api/v1/posts/:id`: Retrieve a specific post.
- `POST /api/v1/posts`: Create a new post.
- `PUT /api/v1/posts/:id`: Update a post's information.
- `DELETE /api/v1/posts/:id`: Delete a post.

### Comments
- `GET /api/v1/posts/:post_id/comments`: List all comments for a post.
- `GET /api/v1/posts/:post_id/comments/:id`: Retrieve a specific comment.
- `POST /api/v1/posts/:post_id/comments`: Create a new comment.
- `PUT /api/v1/posts/:post_id/comments/:id`: Update a comment.
- `DELETE /api/v1/posts/:post_id/comments/:id`: Delete a comment.

### Authentication
- `POST /api/v1/tokens`: Authenticate a user and return a JWT token.

## Extra Features

- **Pagination, Sorting, Filtering, and Searching**: Enhanced the posts endpoint with features like pagination, sorting, filtering by title and tags, and searching.
- **Database Optimization**: Implemented indexing on `tags` in posts and `email` in users for faster database access.
- **Sidekiq and Redis Monitoring UI**: Added a user interface for monitoring Sidekiq and Redis functionality. Integrated necessary middleware to manage sessions, cookies, and rendering of static files.
- **Automated Post Deletion**: Configured Sidekiq to automatically delete posts 24 hours after creation.
- **Comprehensive Testing**: Wrote test cases covering happy and unhappy scenarios for all endpoints, ensuring robustness and reliability.

## Architecture and Local Setup

This project is structured to run in a containerized environment using Docker where architecture comprises several interconnected services managed through Docker Compose:

- **Web Application**: Built on Ruby on Rails, serving the RESTful API.
- **PostgreSQL Database**: Used for data persistence.
- **Redis**: Acts as a cache and a message broker for Sidekiq.
- **Sidekiq**: Handles background job processing, like scheduled post deletions.
- **Middleware**: Manages sessions, cookies, and static file rendering for the Sidekiq Web UI.

Each service is defined and orchestrated using `docker-compose`, providing a cohesive development and deployment environment.

### Building and Running the Application

1. **Build the Containers**:
   ```bash
   docker-compose build
   ```
2. **Start the Services**:
   ```bash
   docker-compose up
   ```
3. **Accessing the Application**:
   - The web application is accessible at `http://localhost:3000`.
   - The Sidekiq Web UI can be accessed at `http://localhost:3000/sidekiq`.
