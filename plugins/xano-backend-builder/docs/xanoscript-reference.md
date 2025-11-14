# XanoScript Reference Guide

Complete syntax reference for XanoScript, Xano's custom scripting language for building backend logic.

## Table of Contents

1. [Core Syntax](#core-syntax)
2. [Primitives](#primitives)
3. [Variables](#variables)
4. [Functions](#functions)
5. [Filters](#filters)
6. [Loops](#loops)
7. [Conditionals](#conditionals)
8. [Common Patterns](#common-patterns)

---

## Core Syntax

### Basic Structure

All XanoScript code follows this pattern:

```xanoscript
<primitive_keyword> <name> <attributes> {
  input { }
  stack { }
  response = <data>
}
```

**Example**:
```xanoscript
api get_users {
  input {
    int limit filters=min:1|max:100
  }

  stack {
    db.query users { limit = $limit } as $users
  }

  response = $users
}
```

### Namespace Notation

Functions are organized by namespace (category):
- `db.*` - Database operations
- `var.*` - Variable operations
- `array.*` - Array operations
- `http.*` - HTTP requests
- `timestamp.*` - Date/time operations

**Format**: `namespace.function parameters { } as $variable`

---

## Primitives

Primitives are top-level constructs in Xano:

### API Endpoint

```xanoscript
api endpoint_name {
  input { }
  stack { }
  response = $result
}
```

### Function

```xanoscript
function function_name {
  input { }
  stack { }
  response = $result
}
```

### Background Task

```xanoscript
task task_name {
  stack { }
}
```

### AI Agent

```xanoscript
agent agent_name {
  input { }
  stack { }
  response = $result
}
```

---

## Variables

### Creating Variables

Use `var` keyword to initialize:

```xanoscript
var $my_variable {
  value = "initial value"
}
```

**Examples**:
```xanoscript
var $counter { value = 0 }
var $items { value = [] }
var $user_data { value = {} }
var $message { value = "Hello" }
```

### Updating Variables

Use `var.update` to modify existing variables:

```xanoscript
var.update $counter {
  value = $counter + 1
}
```

```xanoscript
var.update $items {
  value = $items|push:$new_item
}
```

### Variable Assignment

Functions assign output using `as` keyword:

```xanoscript
db.query users { } as $users
http.request { url = "https://api.example.com" } as $response
```

### Variable Naming

- Always prefix with `$`: `$variable_name`
- Use snake_case: `$user_data`, `$formatted_items`
- Descriptive names: `$active_users` not `$au`

---

## Functions

### Database Functions

**Query**:
```xanoscript
db.query table_name {
  where = { field: value },
  limit = 10,
  offset = 0,
  order = { field: "desc" }
} as $results
```

**Insert**:
```xanoscript
db.insert table_name {
  field1 = $value1,
  field2 = $value2
} as $new_record
```

**Update**:
```xanoscript
db.update table_name {
  where = { id: $user_id },
  set = { status: "active" }
} as $updated_record
```

**Delete**:
```xanoscript
db.delete table_name {
  where = { id: $record_id }
}
```

### Array Functions

**Push** (add to end):
```xanoscript
array.push $my_array {
  value = $new_item
}
```

**Pop** (remove from end):
```xanoscript
array.pop $my_array
```

**Map** (transform each item):
```xanoscript
array.map $items {
  each as $item {
    return = $item.name
  }
} as $names
```

### HTTP Functions

**Request**:
```xanoscript
http.request {
  url = "https://api.example.com/data",
  method = "POST",
  headers = { "Authorization": "Bearer " + $token },
  body = { key: "value" }
} as $response
```

### Timestamp Functions

**Now**:
```xanoscript
timestamp.now as $current_time
```

**Format**:
```xanoscript
timestamp.format $timestamp {
  format = "Y-m-d H:i:s"
} as $formatted
```

---

## Filters

Filters transform data using pipe `|` syntax.

### Basic Syntax

```xanoscript
$data|filter_name
$data|filter_name:option
$data|filter_name:option1:option2
```

### Common Filters

**String Filters**:
```xanoscript
$text|upper                    // Convert to uppercase
$text|lower                    // Convert to lowercase
$text|capitalize               // Capitalize first letter
$text|trim                     // Remove whitespace
$text|length                   // Get string length
$email|is_email                // Check if valid email
```

**Array Filters**:
```xanoscript
$array|count                   // Count items
$array|first                   // Get first item
$array|last                    // Get last item
$array|push:$item              // Add item to end
$array|is_empty                // Check if empty
```

**Object Filters**:
```xanoscript
$object|set:"key":$value       // Set key to value
$object|unset:"key"            // Remove key
$object|get:"key"              // Get value by key
$object|keys                   // Get all keys
$object|values                 // Get all values
```

**Numeric Filters**:
```xanoscript
$number|abs                    // Absolute value
$number|round                  // Round to integer
$number|ceil                   // Round up
$number|floor                  // Round down
```

**Timestamp Filters**:
```xanoscript
$timestamp|format_timestamp:"Y-m-d H:i:s"
$timestamp|timestamp_offset:3600    // Add seconds
```

**Logical Filters**:
```xanoscript
$value|not                     // Logical NOT
$value|is_null                 // Check if null
$value|is_empty                // Check if empty
```

### Chaining Filters

Filters can be chained:

```xanoscript
$user.email|trim|lower|is_email
$items|count|round
$text|trim|upper|length
```

### Filter Examples

**Validate email**:
```xanoscript
conditional {
  if ($email|trim|is_email|not) {
    response.error "Invalid email"
  }
}
```

**Transform array of objects**:
```xanoscript
foreach ($users) {
  each as $user {
    var.update $formatted_users {
      value = $formatted_users|push:($user|set:"name":($user.name|upper))
    }
  }
}
```

---

## Loops

### ForEach Loop

Iterate over arrays or collections:

```xanoscript
foreach ($items) {
  each as $item {
    // Process each item
  }
}
```

**With Index**:
```xanoscript
foreach ($items) {
  each as $item, $index {
    // $index starts at 0
  }
}
```

**Example**:
```xanoscript
var $formatted { value = [] }

foreach ($users) {
  each as $user {
    var $full_name {
      value = $user.first_name + " " + $user.last_name
    }

    var.update $formatted {
      value = $formatted|push:{
        id: $user.id,
        name: $full_name
      }
    }
  }
}
```

### For Loop

Iterate a specific number of times:

```xanoscript
for (10) {
  each as $index {
    // $index: 0, 1, 2, ... 9
  }
}
```

**Example**:
```xanoscript
var $numbers { value = [] }

for (5) {
  each as $i {
    var.update $numbers {
      value = $numbers|push:($i + 1)
    }
  }
}
// Result: [1, 2, 3, 4, 5]
```

### While Loop

Repeat while condition is true:

```xanoscript
while ($condition) {
  each {
    // Update condition to eventually exit
  }
}
```

**Example**:
```xanoscript
var $count { value = 0 }

while ($count < 5) {
  each {
    var.update $count {
      value = $count + 1
    }
  }
}
```

---

## Conditionals

### If Statement

```xanoscript
conditional {
  if ($condition) {
    // Execute if true
  }
}
```

### If-Else

```xanoscript
conditional {
  if ($condition) {
    // Execute if true
  }
  else {
    // Execute if false
  }
}
```

### If-ElseIf-Else

```xanoscript
conditional {
  if ($condition1) {
    // First condition
  }
  elseif ($condition2) {
    // Second condition
  }
  elseif ($condition3) {
    // Third condition
  }
  else {
    // None matched
  }
}
```

### Comparison Operators

In conditionals and filters:

```xanoscript
$a == $b        // Equals
$a != $b        // Not equals
$a > $b         // Greater than
$a < $b         // Less than
$a >= $b        // Greater than or equal
$a <= $b        // Less than or equal
```

### Logical Operators

```xanoscript
$a and $b       // Logical AND
$a or $b        // Logical OR
$value|not      // Logical NOT (using filter)
```

### Examples

**Validate input**:
```xanoscript
conditional {
  if ($email|is_empty) {
    response.error "Email is required"
  }
  elseif ($email|is_email|not) {
    response.error "Invalid email format"
  }
}
```

**Role-based logic**:
```xanoscript
conditional {
  if ($user.role == "admin") {
    db.query all_records { } as $records
  }
  elseif ($user.role == "user") {
    db.query records {
      where = { user_id: $user.id }
    } as $records
  }
  else {
    response.error "Unauthorized"
  }
}
```

---

## Common Patterns

### Pattern 1: API CRUD Endpoint

```xanoscript
api create_user {
  input {
    text email filters=required|is_email
    text name filters=required|trim
  }

  stack {
    // Validate unique email
    db.query users {
      where = { email: $email }
    } as $existing

    conditional {
      if ($existing|count > 0) {
        response.error "Email already exists"
      }
    }

    // Create user
    db.insert users {
      email = $email|lower|trim,
      name = $name|trim,
      created_at = timestamp.now
    } as $new_user

    response = {
      success: true,
      user: $new_user
    }
  }
}
```

### Pattern 2: Data Transformation

```xanoscript
function format_users {
  input {
    array raw_users
  }

  stack {
    var $formatted { value = [] }

    foreach ($raw_users) {
      each as $user {
        var $user_obj {
          value = {
            id: $user.id,
            name: $user.first_name + " " + $user.last_name,
            email: $user.email|lower,
            created: $user.created_at|format_timestamp:"Y-m-d"
          }
        }

        var.update $formatted {
          value = $formatted|push:$user_obj
        }
      }
    }

    response = $formatted
  }
}
```

### Pattern 3: External API Call

```xanoscript
function fetch_external_data {
  input {
    text endpoint
  }

  stack {
    http.request {
      url = "https://api.example.com/" + $endpoint,
      method = "GET",
      headers = {
        "Authorization": "Bearer " + env.API_KEY
      }
    } as $response

    conditional {
      if ($response.status != 200) {
        response.error "API request failed"
      }
    }

    response = $response.body
  }
}
```

### Pattern 4: Conditional Processing

```xanoscript
api process_order {
  input {
    int order_id
    text action
  }

  stack {
    db.query orders {
      where = { id: $order_id }
    } as $order

    conditional {
      if ($action == "approve") {
        db.update orders {
          where = { id: $order_id },
          set = {
            status: "approved",
            approved_at: timestamp.now
          }
        }
      }
      elseif ($action == "reject") {
        db.update orders {
          where = { id: $order_id },
          set = {
            status: "rejected",
            rejected_at: timestamp.now
          }
        }
      }
      else {
        response.error "Invalid action"
      }
    }

    response = { success: true }
  }
}
```

### Pattern 5: Aggregate and Filter

```xanoscript
api get_user_stats {
  input {
    int user_id
  }

  stack {
    // Get user's orders
    db.query orders {
      where = { user_id: $user_id }
    } as $orders

    // Calculate totals
    var $total_amount { value = 0 }
    var $completed_count { value = 0 }

    foreach ($orders) {
      each as $order {
        var.update $total_amount {
          value = $total_amount + $order.amount
        }

        conditional {
          if ($order.status == "completed") {
            var.update $completed_count {
              value = $completed_count + 1
            }
          }
        }
      }
    }

    response = {
      total_orders: $orders|count,
      completed_orders: $completed_count,
      total_spent: $total_amount
    }
  }
}
```

---

## Best Practices

### 1. Initialize Variables Early

```xanoscript
// ✅ Good
var $results { value = [] }
foreach ($items) {
  each as $item {
    var.update $results { value = $results|push:$item }
  }
}

// ❌ Bad - undefined variable
foreach ($items) {
  each as $item {
    var.update $results { value = $results|push:$item }  // Error!
  }
}
```

### 2. Use Filters for Validation

```xanoscript
// ✅ Good
conditional {
  if ($email|is_email|not) {
    response.error "Invalid email"
  }
}

// ❌ Bad - manual validation
conditional {
  if ($email.indexOf("@") == -1) {  // Not XanoScript syntax
    response.error "Invalid email"
  }
}
```

### 3. Chain Filters for Readability

```xanoscript
// ✅ Good
$user.email|trim|lower

// ❌ Less readable
var $temp1 { value = $user.email|trim }
var $temp2 { value = $temp1|lower }
```

### 4. Use Meaningful Variable Names

```xanoscript
// ✅ Good
$active_users
$formatted_response
$total_amount

// ❌ Bad
$au
$fr
$ta
```

### 5. Handle Errors Gracefully

```xanoscript
// ✅ Good
http.request { url = $api_url } as $response

conditional {
  if ($response.status != 200) {
    response.error "External API failed: " + $response.status
  }
}

// ❌ Bad - no error handling
http.request { url = $api_url } as $response
response = $response.body  // Might fail if request errored
```

---

## Quick Reference

### Most Common Operations

**Database**:
- `db.query table { } as $results` - Fetch records
- `db.insert table { field = value } as $record` - Create record
- `db.update table { where, set } as $record` - Update record
- `db.delete table { where }` - Delete record

**Variables**:
- `var $name { value = x }` - Create variable
- `var.update $name { value = y }` - Update variable
- `function_call { } as $result` - Assign function result

**Arrays**:
- `$array|count` - Get length
- `$array|first` - First item
- `$array|last` - Last item
- `$array|push:$item` - Add item

**Strings**:
- `$str|trim` - Remove whitespace
- `$str|upper` - Uppercase
- `$str|lower` - Lowercase
- `$str|is_email` - Validate email

**Control Flow**:
- `conditional { if ($cond) { } }` - If statement
- `foreach ($arr) { each as $item { } }` - Loop array
- `for (n) { each as $i { } }` - Loop n times
- `while ($cond) { each { } }` - While loop

---

## Additional Resources

- **Official Docs**: https://docs.xano.com/xanoscript/key-concepts
- **Xano Transform**: https://docs.xano.com/xano-transform/using-xano-transform
- **Function Reference**: https://www.xano.com/learn/Functions-Data-Transformation-Business-Logic/
- **VS Code Extension**: https://marketplace.visualstudio.com/items?itemName=xano.xanoscript

---

**Remember**: XanoScript is unique to Xano. When in doubt, check examples in the Xano visual editor or reference this guide. Test syntax incrementally to ensure correctness.
