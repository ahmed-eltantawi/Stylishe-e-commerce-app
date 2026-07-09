# API Documentation

# Overview

This API provides a complete backend for an e-commerce application. It allows applications to manage products, categories, users, authentication, file uploads, and locations through RESTful endpoints.

It is designed for learning, prototyping, testing, and developing applications without the need to build a backend from scratch.

The API communicates using JSON and follows standard HTTP methods such as **GET**, **POST**, **PUT**, and **DELETE**.

---

# Base URL

```
https://api.escuelajs.co/api/v1
```

Every endpoint in this documentation is relative to the base URL.

Example:

```
GET https://api.escuelajs.co/api/v1/products
```

---

# Features

The API includes support for:

- Products management
- Categories management
- User management
- JWT Authentication
- File uploads
- Pagination
- Filtering
- Search
- Location services
- CRUD operations
- REST API
- GraphQL support

---

# Resources

The API is organized into several resources.

| Resource | Description |
|----------|-------------|
| Products | Manage store products |
| Categories | Organize products into categories |
| Users | Create and manage users |
| Authentication | Login and JWT authentication |
| Files | Upload and retrieve files |
| Locations | Retrieve location data |

---

# Authentication

Some endpoints require authentication.

Authentication is performed using a JWT access token.

Include the token inside the Authorization header.

Example:

```http
Authorization: Bearer YOUR_ACCESS_TOKEN
```

The authentication flow is:

```
Login
      │
      ▼
Receive Access Token
      │
      ▼
Store Token
      │
      ▼
Use Token in Protected Requests
```

---

# Request Format

Requests are sent using HTTP methods.

## GET

Retrieve data.

Example:

```http
GET /products
```

---

## POST

Create new resources.

Example:

```http
POST /products
```

---

## PUT

Update an existing resource.

Example:

```http
PUT /products/1
```

---

## DELETE

Delete a resource.

Example:

```http
DELETE /products/1
```

---

# Response Format

Successful responses return JSON.

Example:

```json
{
  "id": 1,
  "title": "Product",
  "price": 150
}
```

If an endpoint returns multiple items:

```json
[
  {
    "id": 1,
    "title": "Product A"
  },
  {
    "id": 2,
    "title": "Product B"
  }
]
```

---

# Status Codes

| Code | Description |
|------|-------------|
|200|Success|
|201|Created Successfully|
|204|No Content|
|400|Bad Request|
|401|Unauthorized|
|403|Forbidden|
|404|Not Found|
|409|Conflict|
|422|Validation Error|
|500|Internal Server Error|

---

# How the API Works

Every request follows the same lifecycle.

```
Client
   │
   ▼
HTTP Request
   │
   ▼
API Server
   │
   ▼
Validation
   │
   ▼
Business Logic
   │
   ▼
Database
   │
   ▼
JSON Response
   │
   ▼
Client
```

1. The client sends an HTTP request.
2. The server validates the request.
3. Authentication is verified (if required).
4. Business logic is executed.
5. Data is retrieved or updated.
6. A JSON response is returned.

---

# How to Use the API

## 1. Retrieve Products

Request

```http
GET /products
```

Returns all available products.

---

## 2. Retrieve a Single Product

```http
GET /products/{id}
```

Example

```http
GET /products/1
```

Returns the product with ID **1**.

---

## 3. Create a Product

```http
POST /products
```

Request Body

```json
{
  "title": "Gaming Mouse",
  "price": 50,
  "description": "RGB Gaming Mouse",
  "categoryId": 1,
  "images": [
    "https://example.com/image.png"
  ]
}
```

Returns the newly created product.

---

## 4. Update a Product

```http
PUT /products/{id}
```

Example

```json
{
  "title": "Updated Product",
  "price": 100
}
```

Only the supplied fields are updated.

---

## 5. Delete a Product

```http
DELETE /products/{id}
```

Returns

```json
true
```

if deletion succeeds.

---

# Pagination

Large collections can be retrieved using pagination.

Example

```http
GET /products?offset=0&limit=10
```

Parameters

| Parameter | Description |
|------------|-------------|
| offset | Number of items to skip |
| limit | Maximum number of returned items |

Example

```
offset=0
limit=10
```

Returns the first 10 products.

---

# Filtering

Products can be filtered using query parameters.

Examples

Filter by title

```http
GET /products?title=Phone
```

Filter by category

```http
GET /products?categoryId=1
```

Filter by price

```http
GET /products?price=500
```

Filter by price range

```http
GET /products?price_min=100&price_max=500
```

Multiple filters can be combined.

Example

```http
GET /products?categoryId=1&price_min=100&price_max=500&limit=10
```

---

# User Authentication

## Login

```http
POST /auth/login
```

Request

```json
{
  "email": "john@mail.com",
  "password": "changeme"
}
```

Response

```json
{
  "access_token": "...",
  "refresh_token": "..."
}
```

---

## Access Protected Endpoints

Include the access token.

```http
Authorization: Bearer ACCESS_TOKEN
```

Example

```http
GET /auth/profile
```

Returns the authenticated user's profile.

---

## Refresh Token

```http
POST /auth/refresh-token
```

Request

```json
{
  "refreshToken": "YOUR_REFRESH_TOKEN"
}
```

Returns a new access token.

---

# File Upload

Upload files using multipart/form-data.

```
POST /files/upload
```

Response

```json
{
  "filename": "image.png",
  "location": "https://..."
}
```

The returned URL can later be used as a product image.

---

# Error Handling

Errors are returned as JSON.

Example

```json
{
  "statusCode": 404,
  "message": "Product not found"
}
```

Applications should always verify the returned HTTP status code before processing the response.

---

# Best Practices

- Always use HTTPS.
- Validate request data before sending.
- Store JWT tokens securely.
- Refresh expired access tokens when necessary.
- Handle HTTP errors properly.
- Use pagination when retrieving large datasets.
- Avoid requesting unnecessary data.
- Cache frequently accessed resources whenever possible.

---

# Example Workflow

```
Login
   │
   ▼
Receive JWT Token
   │
   ▼
Request Products
   │
   ▼
Display Products
   │
   ▼
Create Order
   │
   ▼
Upload Images (Optional)
   │
   ▼
Logout
```

---

# API Summary

This API provides everything needed to build a complete e-commerce application.

It includes:

- Product management
- Category management
- User management
- Authentication
- File uploads
- Location services
- Pagination
- Filtering
- Full CRUD operations

The API follows REST principles, uses JSON for all requests and responses, and supports JWT authentication for secure access to protected resources.