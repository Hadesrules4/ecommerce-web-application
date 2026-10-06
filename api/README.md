# REST API Documentation

Base URL: `http://127.0.0.1:5000`

## Public product APIs

### GET /api/products
Returns all products.

### GET /api/products/<id>
Returns one product or HTTP 404.

## Admin product APIs

Authentication must be established through the web login and the logged-in user must have `role=admin`.

### POST /api/products
Example JSON:
```json
{
  "name": "Laptop",
  "description": "Example product",
  "price": 55000,
  "stock": 10,
  "category": "Electronics",
  "image": ""
}
```

### PUT /api/products/<id>
Accepts any supported product fields.

### DELETE /api/products/<id>
Deletes a product when it is not referenced by existing order items.

## Order APIs

### GET /api/orders
Admin only. Returns all orders.

### GET /api/orders/<id>
Logged-in user can retrieve their own order; an admin can retrieve any order.

### PUT /api/orders/<id>/status
Admin only. Example:
```json
{"status":"Shipped"}
```

Allowed statuses:
`Pending`, `Processing`, `Shipped`, `Delivered`, `Cancelled`.

## HTTP status conventions

- `200` Success
- `201` Created
- `400` Invalid request
- `404` Resource not found
- `409` Conflict