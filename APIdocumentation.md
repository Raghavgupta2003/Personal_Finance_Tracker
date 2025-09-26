# 📚 Personal Finance Tracker - API Documentation

## Base URL
```
http://localhost:5000/api
```

## Authentication
This API uses JWT (JSON Web Token) for authentication. Include the token in the Authorization header for protected routes:

```
Authorization: Bearer <your_jwt_token>
```

---

## 🔐 Authentication Endpoints

### Register User
```http
POST /auth/register
```

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123",
  "role": "user" // Optional: "user", "read-only", "admin"
}
```

**Response:**
```json
{
  "message": "User registered successfully",
  "userId": 1
}
```

**Status Codes:**
- `201` - Created
- `400` - Bad Request (validation errors, user exists)

---

### Login User
```http
POST /auth/login
```

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "role": "user"
  }
}
```

**Status Codes:**
- `200` - OK
- `401` - Unauthorized (invalid credentials)

---

### Test Protected Route
```http
GET /auth/protected
```

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "message": "Hello, John Doe!"
}
```

---

### Admin Only Route
```http
GET /auth/admin-only
```

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "message": "Welcome Admin!"
}
```

**Status Codes:**
- `200` - OK
- `403` - Forbidden (insufficient permissions)

---

## 💰 Transaction Endpoints

### Get All Transactions
```http
GET /transactions
```

**Headers:**
```
Authorization: Bearer <token>
```

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| type | string | Filter by "income" or "expense" |
| category | string | Filter by category name |
| startDate | string | Start date (YYYY-MM-DD) |
| endDate | string | End date (YYYY-MM-DD) |

**Example:**
```http
GET /transactions?type=expense&category=Food&startDate=2024-01-01&endDate=2024-12-31
```

**Response:**
```json
{
  "transactions": [
    {
      "id": 1,
      "user_id": 1,
      "type": "expense",
      "category": "Food",
      "amount": 25.50,
      "description": "Lunch at restaurant",
      "date": "2024-01-15"
    }
  ]
}
```

---

### Create Transaction
```http
POST /transactions
```

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "type": "expense",
  "category": "Food",
  "amount": 25.50,
  "description": "Lunch at restaurant",
  "date": "2024-01-15"
}
```

**Response:**
```json
{
  "message": "Transaction added",
  "insertId": 1
}
```

**Status Codes:**
- `201` - Created
- `403` - Forbidden (read-only users cannot create)

---

### Update Transaction
```http
PUT /transactions/:id
```

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "type": "income",
  "category": "Salary",
  "amount": 3000.00,
  "description": "Monthly salary",
  "date": "2024-01-01"
}
```

**Response:**
```json
{
  "message": "Transaction updated successfully"
}
```

**Status Codes:**
- `200` - OK
- `404` - Not Found
- `403` - Forbidden

---

### Delete Transaction
```http
DELETE /transactions/:id
```

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "message": "Transaction deleted successfully"
}
```

**Status Codes:**
- `200` - OK
- `404` - Not Found
- `403` - Forbidden

---

## 📊 Analytics Endpoints

### Get Dashboard Analytics
```http
GET /analytics/dashboard
```

**Headers:**
```
Authorization: Bearer <token>
```

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| period | string | "month" or "year" (default: "month") |
| year | number | Year filter (default: current year) |
| month | number | Month filter (1-12, required if period="month") |

**Example:**
```http
GET /analytics/dashboard?period=month&year=2024&month=1
```

**Response:**
```json
{
  "totalIncome": 5000.00,
  "totalExpenses": 3000.00,
  "netIncome": 2000.00,
  "period": "month",
  "year": 2024,
  "month": 1
}
```

---

### Get Monthly Trends
```http
GET /analytics/monthly-trends
```

**Headers:**
```
Authorization: Bearer <token>
```

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| year | number | Year filter (default: current year) |

**Response:**
```json
[
  {
    "month": 1,
    "income": 5000.00,
    "expenses": 3000.00
  },
  {
    "month": 2,
    "income": 5200.00,
    "expenses": 2800.00
  }
]
```

---

### Get Category Breakdown
```http
GET /analytics/category-breakdown
```

**Headers:**
```
Authorization: Bearer <token>
```

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| period | string | "month" or "year" (default: "month") |
| year | number | Year filter (default: current year) |
| month | number | Month filter (required if period="month") |

**Response:**
```json
[
  {
    "category": "Food",
    "type": "expense",
    "amount": 800.00
  },
  {
    "category": "Transport",
    "type": "expense",
    "amount": 200.00
  },
  {
    "category": "Salary",
    "type": "income",
    "amount": 5000.00
  }
]
```

---

### Get Income vs Expense
```http
GET /analytics/income-vs-expense
```

**Headers:**
```
Authorization: Bearer <token>
```

**Query Parameters:**
| Parameter | Type | Description |
|-----------|------|-------------|
| period | string | "month" or "year" (default: "month") |
| year | number | Year filter (default: current year) |
| month | number | Month filter (required if period="month") |

**Response:**
```json
[
  {
    "date": "2024-01-01",
    "income": 1000.00,
    "expenses": 300.00
  },
  {
    "date": "2024-01-02",
    "income": 0.00,
    "expenses": 25.50
  }
]
```

---

## 🎯 Data Models

### User Model
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john@example.com",
  "role": "user", // "user", "read-only", "admin"
  "created_at": "2024-01-01T00:00:00.000Z",
  "updated_at": "2024-01-01T00:00:00.000Z"
}
```

### Transaction Model
```json
{
  "id": 1,
  "user_id": 1,
  "type": "expense", // "income" or "expense"
  "category": "Food",
  "amount": 25.50,
  "description": "Lunch at restaurant",
  "date": "2024-01-15",
  "created_at": "2024-01-15T12:00:00.000Z",
  "updated_at": "2024-01-15T12:00:00.000Z"
}
```

---

## 🏷️ Categories

### Expense Categories
- Food
- Transport
- Entertainment
- Shopping
- Healthcare
- Education
- Housing
- Utilities
- Insurance
- Other

### Income Categories
- Salary
- Freelance
- Investment
- Business
- Gift
- Other

---

## 🔒 User Roles & Permissions

| Role | View Transactions | Add/Edit/Delete | Admin Analytics |
|------|------------------|-----------------|-----------------|
| **admin** | All users' data | ✅ | ✅ |
| **user** | Own data only | ✅ | ❌ |
| **read-only** | Own data only | ❌ | ❌ |

---

## ❌ Error Responses

### Validation Error (400)
```json
{
  "message": "Name, email, and password are required"
}
```

### Unauthorized (401)
```json
{
  "message": "Not authorized"
}
```

### Forbidden (403)
```json
{
  "message": "Forbidden: Insufficient permissions"
}
```

### Not Found (404)
```json
{
  "message": "Transaction not found or unauthorized"
}
```

### Server Error (500)
```json
{
  "message": "Server error"
}
```

---

## 📋 Example Usage

### Complete Flow Example

#### 1. Register a new user
```bash
curl -X POST http://localhost:5000/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123",
    "role": "user"
  }'
```

#### 2. Login to get token
```bash
curl -X POST http://localhost:5000/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "password123"
  }'
```

#### 3. Add a transaction
```bash
curl -X POST http://localhost:5000/api/transactions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE" \
  -d '{
    "type": "expense",
    "category": "Food",
    "amount": 25.50,
    "description": "Lunch at restaurant",
    "date": "2024-01-15"
  }'
```

#### 4. Get analytics
```bash
curl -X GET "http://localhost:5000/api/analytics/dashboard?period=month&year=2024&month=1" \
  -H "Authorization: Bearer YOUR_TOKEN_HERE"
```

---

## 🚀 Rate Limiting & Caching

- **Redis Caching**: Analytics data is cached to improve performance
- **Cache Invalidation**: Automatic cache clearing when transactions are modified
- **JWT Expiry**: Tokens expire after 24 hours

---

## 🔧 Development Notes

1. **Database**: Uses MySQL with connection pooling
2. **Security**: Passwords are hashed with bcrypt
3. **CORS**: Enabled for cross-origin requests
4. **Environment**: Requires `.env` file with database and Redis credentials

For more details, visit the [GitHub Repository](https://github.com/Raghavgupta2003/Personal_Finance_Tracker).