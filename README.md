# Barangay Management System - Laravel Backend API

A comprehensive Laravel 11 backend API for managing barangay residents, business clearances, building clearances, and barangay clearances.

## Features

- ✅ Laravel 11 with MVC Architecture
- ✅ MySQL Database
- ✅ Laravel Sanctum Authentication
- ✅ RESTful API with CRUD operations
- ✅ File upload support (photos, attachments)
- ✅ Search and pagination
- ✅ Input validation and sanitization
- ✅ CORS configuration for frontend integration
- ✅ Rate limiting and security middleware

## Requirements

- PHP >= 8.2
- Composer
- MySQL >= 5.7 or MariaDB >= 10.3
- Node.js & NPM (for asset compilation, optional)

## Installation

1. **Clone the repository**
   ```bash
   cd "C:\Users\CK\Desktop\Barangay MIS"
   ```

2. **Install dependencies**
   ```bash
   composer install
   ```

3. **Create environment file**
   ```bash
   copy .env.example .env
   ```

4. **Generate application key**
   ```bash
   php artisan key:generate
   ```

5. **Configure database**
   Edit `.env` file and set your database credentials:
   ```env
   DB_CONNECTION=mysql
   DB_HOST=127.0.0.1
   DB_PORT=3306
   DB_DATABASE=barangay_mis
   DB_USERNAME=root
   DB_PASSWORD=your_password
   ```

6. **Run migrations**
   ```bash
   php artisan migrate
   ```

7. **Create storage link**
   ```bash
   php artisan storage:link
   ```

8. **Start the development server**
   ```bash
   php artisan serve
   ```

   The API will be available at `http://localhost:8000`

## API Endpoints

### Authentication

- `POST /api/register` - Register a new user
- `POST /api/login` - Login and get token
- `POST /api/logout` - Logout (requires authentication)

### Residents

- `GET /api/residents` - List all residents (with pagination & search)
- `GET /api/residents/{id}` - Get single resident
- `POST /api/residents` - Create new resident
- `PUT /api/residents/{id}` - Update resident
- `DELETE /api/residents/{id}` - Delete resident

### Business Clearances

- `GET /api/business-clearances` - List all business clearances
- `GET /api/business-clearances/{id}` - Get single business clearance
- `POST /api/business-clearances` - Create new business clearance
- `PUT /api/business-clearances/{id}` - Update business clearance
- `DELETE /api/business-clearances/{id}` - Delete business clearance

### Building Clearances

- `GET /api/building-clearances` - List all building clearances
- `GET /api/building-clearances/{id}` - Get single building clearance
- `POST /api/building-clearances` - Create new building clearance
- `PUT /api/building-clearances/{id}` - Update building clearance
- `DELETE /api/building-clearances/{id}` - Delete building clearance

### Barangay Clearances

- `GET /api/barangay-clearances` - List all barangay clearances
- `GET /api/barangay-clearances/{id}` - Get single barangay clearance
- `POST /api/barangay-clearances` - Create new barangay clearance
- `PUT /api/barangay-clearances/{id}` - Update barangay clearance
- `DELETE /api/barangay-clearances/{id}` - Delete barangay clearance

## Authentication

All protected routes require authentication via Laravel Sanctum. Include the token in the Authorization header:

```
Authorization: Bearer {your_token_here}
```

### Example: Register User

```bash
POST /api/register
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123",
  "password_confirmation": "password123"
}
```

### Example: Login

```bash
POST /api/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "password123"
}
```

Response:
```json
{
  "status": "success",
  "message": "Login successful",
  "data": {
    "user": {...},
    "token": "1|xxxxxxxxxxxxx"
  }
}
```

## Search & Filtering

All list endpoints support search and filtering:

- `?search=keyword` - Search by surname, first_name, trans_number, etc.
- `?zone=Zone1` - Filter by zone
- `?per_page=20` - Set pagination limit (default: 15)

Example:
```
GET /api/residents?search=Juan&zone=Zone1&per_page=20
```

## File Uploads

### Resident Photo
- Field: `photo`
- Allowed: JPG, JPEG, PNG
- Max size: 2MB
- Storage: `storage/app/public/residents/photos`

### Business Clearance Attachment
- Field: `attachment`
- Allowed: JPG, JPEG, PNG, PDF
- Max size: 5MB
- Storage: `storage/app/public/clearances/business/attachments`

## Response Format

All API responses follow this format:

```json
{
  "status": "success|error",
  "message": "Human readable message",
  "data": {...}
}
```

## Security Features

- ✅ CSRF protection for web routes
- ✅ SQL injection protection via Eloquent ORM
- ✅ Input validation and sanitization
- ✅ Mass assignment protection with `$fillable`
- ✅ Secure file storage
- ✅ Rate limiting via `throttle:api` middleware
- ✅ Authentication via Laravel Sanctum

## Database Tables

1. **residents** - Resident information and records
2. **barangay_business_clearances** - Business clearance records
3. **barangay_building_clearances** - Building clearance records
4. **barangay_clearances** - General barangay clearance records
5. **users** - System users
6. **personal_access_tokens** - Sanctum authentication tokens

## Development

### Running Tests
```bash
php artisan test
```

### Code Style
```bash
./vendor/bin/pint
```

## License

MIT License

