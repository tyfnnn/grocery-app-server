# Grocery App Server

A production-ready REST API server built with **Vapor 4** and **Swift 6**, providing the backend infrastructure for the GroceryApp iOS application. This server demonstrates modern server-side Swift development with PostgreSQL, JWT authentication, and comprehensive API design.

[🇩🇪 Deutsche Version](README_DE.md)

## 🔗 Related Repositories

- **iOS Client App**: [GroceryApp](https://github.com/tyfnnn/GroceryApp)
- **Shared DTOs**: [GroceryAppSharedDTO](https://github.com/tyfnnn/GroceryAppSharedDTO)

## 🚀 Features

### 🔐 Authentication & Security
- **JWT Authentication** with secure token generation and validation
- **Password hashing** using bcrypt for secure credential storage
- **User registration and login** with comprehensive validation
- **Token-based authorization** for protected endpoints

### 📊 Database Management
- **PostgreSQL** integration with Fluent ORM
- **Database migrations** for version-controlled schema management
- **Relational data modeling** with proper foreign key constraints
- **Cascade operations** for data integrity

### 🛠️ API Endpoints
- **RESTful design** following industry best practices
- **CRUD operations** for users, grocery categories, and items
- **Hierarchical data structure** (Users → Categories → Items)
- **Comprehensive error handling** with proper HTTP status codes

### 🏗️ Modern Architecture
- **Async/await** support throughout the application
- **Type-safe database operations** with Fluent
- **Modular controller design** for maintainable code
- **Shared DTOs** for consistent data contracts

## 📋 API Documentation

### Authentication Endpoints

#### Register User
```http
POST /api/register
Content-Type: application/json

{
  "username": "string",
  "password": "string"
}
```

#### Login User
```http
POST /api/login
Content-Type: application/json

{
  "username": "string", 
  "password": "string"
}
```

### Grocery Category Endpoints

#### Get Categories
```http
GET /api/users/{userId}/grocery-categories
Authorization: Bearer {jwt_token}
```

#### Create Category
```http
POST /api/users/{userId}/grocery-categories
Content-Type: application/json
Authorization: Bearer {jwt_token}

{
  "title": "string",
  "colorCode": "string"
}
```

#### Delete Category
```http
DELETE /api/users/{userId}/grocery-categories/{categoryId}
Authorization: Bearer {jwt_token}
```

### Grocery Item Endpoints

#### Get Items by Category
```http
GET /api/users/{userId}/grocery-categories/{categoryId}/grocery-items
Authorization: Bearer {jwt_token}
```

#### Create Item
```http
POST /api/users/{userId}/grocery-categories/{categoryId}/grocery-items
Content-Type: application/json
Authorization: Bearer {jwt_token}

{
  "title": "string",
  "price": 0.0,
  "quantity": 0
}
```

#### Delete Item
```http
DELETE /api/users/{userId}/grocery-categories/{categoryId}/grocery-items/{itemId}
Authorization: Bearer {jwt_token}
```

## 🛠️ Installation & Setup

### Prerequisites
- **Swift 6.0+**
- **PostgreSQL 12+**
- **Vapor Toolbox** (recommended)

### Database Setup
1. Install and start PostgreSQL:
   ```bash
   # macOS with Homebrew
   brew install postgresql
   brew services start postgresql
   
   # Create database
   createdb grocerydb
   ```

2. Create a PostgreSQL user (optional):
   ```sql
   CREATE USER your_username WITH PASSWORD 'your_password';
   GRANT ALL PRIVILEGES ON DATABASE grocerydb TO your_username;
   ```

### Server Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/tyfnnn/grocery-app-server.git
   cd grocery-app-server
   ```

2. Configure database connection in `Sources/grocery-app-server/configure.swift`:
   ```swift
   let postgresConfig = SQLPostgresConfiguration(
       hostname: "localhost",
       username: "your_username",  // Replace with your username
       password: "your_password",  // Replace with your password
       database: "grocerydb",
       tls: .prefer(try .init(configuration: .clientDefault))
   )
   ```

3. Build the project:
   ```bash
   swift build
   ```

4. Run database migrations:
   ```bash
   swift run grocery-app-server migrate
   ```

5. Start the server:
   ```bash
   swift run
   ```

The server will start on `http://localhost:8080`

### Docker Setup (Alternative)

You can also run the server using Docker:

```bash
# Build the image
docker compose build

# Start the server
docker compose up app
```

## 🗄️ Database Schema

### Users Table
- `id` (UUID, Primary Key)
- `username` (String, Unique)
- `password` (String, Hashed)

### Grocery Categories Table
- `id` (UUID, Primary Key)
- `title` (String)
- `color_code` (String)
- `user_id` (UUID, Foreign Key → Users)

### Grocery Items Table
- `id` (UUID, Primary Key)
- `title` (String)
- `price` (Double)
- `quantity` (Integer)
- `grocery_category_id` (UUID, Foreign Key → Grocery Categories)

## 🧪 Testing

Run the test suite:
```bash
swift test
```

### Test Coverage
- Authentication flow testing
- API endpoint validation
- Database operation testing
- Error handling verification

## 🚀 Deployment

### Production Configuration
1. Set environment variables:
   ```bash
   export LOG_LEVEL=info
   export DATABASE_URL=postgresql://user:pass@host:port/dbname
   export JWT_SECRET=your-secure-secret-key
   ```

2. Build for production:
   ```bash
   swift build -c release
   ```

3. Run with production settings:
   ```bash
   .build/release/grocery-app-server serve --hostname 0.0.0.0 --port 8080
   ```

### Docker Deployment
The included `Dockerfile` provides a production-ready container:
- Multi-stage build for optimized image size
- Security best practices with non-root user
- Static linking for better performance

## 🏗️ Architecture Details

### Project Structure
```
Sources/
├── grocery-app-server/
│   ├── Controllers/          # API route handlers
│   ├── Models/              # Database models
│   ├── Migrations/          # Database schema migrations
│   ├── Extensions/          # DTO extensions for Vapor
│   ├── configure.swift      # App configuration
│   ├── entrypoint.swift     # Application entry point
│   └── routes.swift         # Basic route definitions
```

### Key Components

#### Models
- **User**: User account management with authentication
- **GroceryCategory**: User-specific grocery categories
- **GroceryItem**: Items within categories
- **AuthPayload**: JWT token payload structure

#### Controllers
- **UserController**: Registration and authentication
- **GroceryController**: CRUD operations for categories and items

#### Security Features
- Password hashing with bcrypt
- JWT token generation and validation
- Protected routes with authentication middleware
- Input validation and sanitization

## 🔧 Configuration

### Environment Variables
- `LOG_LEVEL`: Logging verbosity (debug, info, warning, error)
- `DATABASE_URL`: PostgreSQL connection string
- `JWT_SECRET`: Secret key for JWT signing (change in production!)

### Database Configuration
The server uses Fluent ORM with PostgreSQL. Connection settings can be modified in `configure.swift`.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Ensure all tests pass
6. Submit a pull request

## 📚 Learning Resources

This server demonstrates:
- **Modern Swift Server Development** with Vapor 4
- **Database Design** with proper normalization and relationships
- **RESTful API Design** following best practices
- **Authentication & Authorization** with JWT
- **Testing Strategies** for server-side applications
- **Deployment Practices** with Docker and production configurations

## 📄 License

This project is available for educational use. See LICENSE file for details.

---

💧 Built with [Vapor](https://vapor.codes) - A server-side Swift web framework
