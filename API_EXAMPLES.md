# API Usage Examples

## Authentication

### Register
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

**Response:**
```json
{
  "status": "success",
  "message": "User registered successfully",
  "data": {
    "user": {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "created_at": "2024-01-01T00:00:00.000000Z",
      "updated_at": "2024-01-01T00:00:00.000000Z"
    },
    "token": "1|xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
}
```

### Login
```bash
POST /api/login
Content-Type: application/json

{
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "status": "success",
  "message": "Login successful",
  "data": {
    "user": {...},
    "token": "1|xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
  }
}
```

### Logout
```bash
POST /api/logout
Authorization: Bearer {token}
```

---

## Residents API

### List All Residents
```bash
GET /api/residents?search=Juan&zone=Zone1&per_page=20
Authorization: Bearer {token}
```

**Query Parameters:**
- `search` - Search by surname, first_name, resident_id, or zone
- `zone` - Filter by zone
- `per_page` - Number of items per page (default: 15)

### Get Single Resident
```bash
GET /api/residents/1
Authorization: Bearer {token}
```

### Create Resident
```bash
POST /api/residents
Authorization: Bearer {token}
Content-Type: multipart/form-data

{
  "resident_id": "RES-001",
  "surname": "Dela Cruz",
  "first_name": "Juan",
  "middle_name": "Santos",
  "date_of_birth": "1990-01-15",
  "zone": "Zone 1",
  "phone_number": "+63 912 345 6789",
  "email_address": "juan@example.com",
  "photo": [file]
}
```

### Update Resident
```bash
PUT /api/residents/1
Authorization: Bearer {token}
Content-Type: multipart/form-data

{
  "surname": "Dela Cruz",
  "first_name": "Juan Carlos",
  "phone_number": "+63 912 345 6789"
}
```

### Delete Resident
```bash
DELETE /api/residents/1
Authorization: Bearer {token}
```

---

## Business Clearances API

### List All Business Clearances
```bash
GET /api/business-clearances?search=Store&zone=Zone1
Authorization: Bearer {token}
```

### Create Business Clearance
```bash
POST /api/business-clearances
Authorization: Bearer {token}
Content-Type: multipart/form-data

{
  "trans_number": "BC-2024-001",
  "bcert_number": "BCERT-2024-001",
  "issued_date": "2024-01-15",
  "surname": "Garcia",
  "first_name": "Maria",
  "business_name": "Maria's Store",
  "business_type": "Retail",
  "capital": 50000,
  "zone": "Zone 2",
  "contact_no": "+63 912 345 6789",
  "attachment": [file]
}
```

### Update Business Clearance
```bash
PUT /api/business-clearances/1
Authorization: Bearer {token}
Content-Type: multipart/form-data

{
  "business_name": "Maria's Super Store",
  "capital": 75000
}
```

### Delete Business Clearance
```bash
DELETE /api/business-clearances/1
Authorization: Bearer {token}
```

---

## Building Clearances API

### List All Building Clearances
```bash
GET /api/building-clearances?search=Building
Authorization: Bearer {token}
```

### Create Building Clearance
```bash
POST /api/building-clearances
Authorization: Bearer {token}
Content-Type: application/json

{
  "trans_number": "BLD-2024-001",
  "bcert_number": "BCERT-BLD-001",
  "issued_date": "2024-01-15",
  "surname": "Reyes",
  "first_name": "Pedro",
  "establishment": "Reyes Building",
  "zone": "Zone 3",
  "purpose": "Commercial",
  "contact_no": "+63 912 345 6789"
}
```

---

## Barangay Clearances API

### List All Barangay Clearances
```bash
GET /api/barangay-clearances?search=Clearance
Authorization: Bearer {token}
```

### Create Barangay Clearance
```bash
POST /api/barangay-clearances
Authorization: Bearer {token}
Content-Type: application/json

{
  "trans_number": "BRG-2024-001",
  "bcert_number": "BCERT-BRG-001",
  "issued_date": "2024-01-15",
  "surname": "Lopez",
  "first_name": "Ana",
  "zone": "Zone 1",
  "dob": "1985-05-20",
  "pob": "Manila",
  "contact_no": "+63 912 345 6789",
  "purpose": "Employment",
  "period_of_residency": "5 years"
}
```

---

## Error Responses

All error responses follow this format:

```json
{
  "status": "error",
  "message": "Error message here",
  "data": null
}
```

### Validation Errors
```json
{
  "status": "error",
  "message": "The given data was invalid.",
  "data": {
    "surname": ["The surname field is required."],
    "email_address": ["The email address must be a valid email address."]
  }
}
```

### Authentication Errors
```json
{
  "status": "error",
  "message": "Unauthenticated.",
  "data": null
}
```

---

## Using with cURL

### Example: Create Resident
```bash
curl -X POST http://localhost:8000/api/residents \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -H "Content-Type: application/json" \
  -d '{
    "resident_id": "RES-001",
    "surname": "Dela Cruz",
    "first_name": "Juan",
    "zone": "Zone 1"
  }'
```

### Example: Upload Photo
```bash
curl -X POST http://localhost:8000/api/residents \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -F "resident_id=RES-001" \
  -F "surname=Dela Cruz" \
  -F "first_name=Juan" \
  -F "photo=@/path/to/photo.jpg"
```

---

## Using with JavaScript (Fetch API)

```javascript
// Login
const login = async () => {
  const response = await fetch('http://localhost:8000/api/login', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      email: 'john@example.com',
      password: 'password123'
    })
  });
  
  const data = await response.json();
  localStorage.setItem('token', data.data.token);
};

// Get Residents
const getResidents = async () => {
  const token = localStorage.getItem('token');
  const response = await fetch('http://localhost:8000/api/residents', {
    headers: {
      'Authorization': `Bearer ${token}`
    }
  });
  
  const data = await response.json();
  console.log(data.data);
};

// Create Resident
const createResident = async (residentData) => {
  const token = localStorage.getItem('token');
  const formData = new FormData();
  
  Object.keys(residentData).forEach(key => {
    formData.append(key, residentData[key]);
  });
  
  const response = await fetch('http://localhost:8000/api/residents', {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${token}`
    },
    body: formData
  });
  
  const data = await response.json();
  return data;
};
```

