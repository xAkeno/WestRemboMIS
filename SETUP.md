# Quick Setup Guide

## Prerequisites
- PHP >= 8.2
- Composer
- MySQL/MariaDB

## Installation Steps

1. **Install Composer Dependencies**
   ```bash
   composer install
   ```

2. **Environment Setup**
   ```bash
   copy .env.example .env
   php artisan key:generate
   ```

3. **Database Configuration**
   - Edit `.env` file
   - Set your database credentials:
     ```
     DB_DATABASE=barangay_mis
     DB_USERNAME=root
     DB_PASSWORD=your_password
     ```

4. **Run Migrations**
   ```bash
   php artisan migrate
   ```

5. **Create Storage Link**
   ```bash
   php artisan storage:link
   ```

6. **Start Server**
   ```bash
   php artisan serve
   ```

## API Base URL
```
http://localhost:8000/api
```

## Testing the API

### 1. Register a User
```bash
POST http://localhost:8000/api/register
Content-Type: application/json

{
  "name": "Admin User",
  "email": "admin@barangay.com",
  "password": "password123",
  "password_confirmation": "password123"
}
```

### 2. Login
```bash
POST http://localhost:8000/api/login
Content-Type: application/json

{
  "email": "admin@barangay.com",
  "password": "password123"
}
```

Save the token from the response.

### 3. Access Protected Routes
Include the token in the Authorization header:
```
Authorization: Bearer {your_token_here}
```

Example - Get all residents:
```bash
GET http://localhost:8000/api/residents
Authorization: Bearer {your_token_here}
```

## File Structure

```
app/
├── Http/
│   ├── Controllers/
│   │   ├── AuthController.php
│   │   ├── ResidentController.php
│   │   ├── BarangayBusinessClearanceController.php
│   │   ├── BarangayBuildingClearanceController.php
│   │   └── BarangayClearanceController.php
│   ├── Requests/
│   │   ├── StoreResidentRequest.php
│   │   ├── UpdateResidentRequest.php
│   │   └── ... (other form requests)
│   └── Middleware/
├── Models/
│   ├── User.php
│   ├── Resident.php
│   ├── BarangayBusinessClearance.php
│   ├── BarangayBuildingClearance.php
│   └── BarangayClearance.php
└── Providers/

database/
└── migrations/
    ├── 2014_10_12_000000_create_users_table.php
    ├── 2019_12_14_000001_create_personal_access_tokens_table.php
    ├── 2024_01_01_000001_create_residents_table.php
    ├── 2024_01_01_000002_create_barangay_business_clearances_table.php
    ├── 2024_01_01_000003_create_barangay_building_clearances_table.php
    └── 2024_01_01_000004_create_barangay_clearances_table.php

routes/
└── api.php

config/
├── sanctum.php
├── cors.php
└── database.php
```

## Notes

- All file uploads are stored in `storage/app/public`
- Make sure to run `php artisan storage:link` to create the symbolic link
- CORS is configured for local development (localhost:3000, localhost:5173)
- Rate limiting is enabled (60 requests per minute per IP/user)
- All protected routes require authentication via Sanctum token

