---
name: Xano Backend Builder
description: Build and manage no-code backend services with Xano using MCP server integration. Create database tables, API endpoints, custom functions, and business logic using XanoScript. Use when building backend APIs, database schemas, serverless functions, webhooks, or integrating with Xano workspace.
allowed-tools: Read, WebFetch, WebSearch, AskUserQuestion
---

# Xano Backend Builder

Build serverless backend infrastructure using Xano's no-code platform through MCP (Model Context Protocol) server integration. Create databases, REST APIs, custom functions, and business logic using XanoScript without traditional coding.

## Instructions

### Prerequisites

1. **Xano Account and Workspace**:
   - Sign up at https://xano.com
   - Create or access an existing workspace

2. **MCP Access Token and URL**:
   - Navigate to workspace Settings → Metadata API & MCP Server
   - Copy your **MCP Server URL** (e.g., `https://x8ki-letl-twmt.n7.xano.io/mcp`)
   - Generate an **Access Token** with appropriate scopes
   - **CRITICAL**: Token appears only once - save it securely
   - **WARNING**: MCP operations can modify/delete data - use backups for production

3. **MCP Server Configuration**:
   This plugin includes MCP server configuration that connects automatically when enabled.

   **Set environment variables**:
   ```bash
   export XANO_MCP_URL="https://your-workspace.xano.io/mcp"
   export XANO_MCP_TOKEN="your_access_token_here"
   ```

   Or add to your shell profile (`~/.zshrc`, `~/.bashrc`):
   ```bash
   # Xano MCP Configuration
   export XANO_MCP_URL="https://your-workspace.xano.io/mcp"
   export XANO_MCP_TOKEN="your_access_token_here"
   ```

   **Restart Claude Code** after setting environment variables.

   The Xano MCP server will start automatically when this plugin is enabled, and Xano tools will be available in your Claude Code session.

### Understanding Xano Architecture

**Xano Components**:
- **Database Tables**: Store structured data with relationships
- **API Endpoints**: REST endpoints for CRUD operations and custom logic
- **Function Stack**: Visual programming interface using XanoScript
- **Background Tasks**: Scheduled or triggered async operations
- **AI Agents**: Custom AI-powered functions and workflows

**XanoScript Basics**:
Xano uses a proprietary syntax called XanoScript for defining logic. Key characteristics:
- **Namespace functions**: `db.query`, `array.push`, `var.update`
- **Variable assignment**: Use `as $variable_name`
- **Filters**: Transform data with pipe syntax `|filter_name:option`
- **Primitives**: Top-level constructs (API, function, table, etc.)

**Important**: XanoScript syntax is unique to Xano. When working with XanoScript:
- Look for examples in Xano documentation or API responses
- Test syntax incrementally
- Reference [docs/xanoscript-reference.md](docs/xanoscript-reference.md) for detailed syntax guide

### Workflow

1. **Understand the requirement**:
   - What data needs to be stored? (database design)
   - What API endpoints are needed? (GET, POST, PUT, DELETE)
   - What business logic is required? (transformations, validations, external API calls)
   - What integrations are needed? (webhooks, OAuth, third-party APIs)

2. **Design the database schema**:
   - Identify entities (tables) and relationships
   - Define fields with appropriate data types
   - Consider indexes for performance
   - Use MCP tools to create tables:
     ```
     Use Xano MCP tools to create a table with specified fields
     ```

3. **Create API endpoints**:
   - Define REST endpoints (GET, POST, PUT, DELETE)
   - Configure authentication requirements
   - Set up input parameters and validation
   - Build response structure
   - Use MCP tools to create API endpoints

4. **Implement business logic with XanoScript**:
   - Use the Function Stack to build logic
   - **Key XanoScript patterns**:
     - Query database: `db.query table_name { filters } as $results`
     - Create variable: `var $my_var { value = "initial" }`
     - Update variable: `var.update $my_var { value = "new" }`
     - Loop through data: `foreach ($items) { each as $item { } }`
     - Conditional logic: `conditional { if ($condition) { } else { } }`
     - Transform data: `$data|filter_name:option`
   - Reference [docs/xanoscript-reference.md](docs/xanoscript-reference.md) for detailed syntax

5. **Test the implementation**:
   - Use Xano's built-in API testing interface
   - Verify database operations
   - Check response formats
   - Test error handling
   - Validate authentication flows

6. **Generate API documentation**:
   - Use MCP tools to generate OpenAPI specifications
   - Share with frontend developers
   - Document authentication requirements

7. **Deploy and monitor**:
   - Test in Xano's staging environment
   - Deploy to production
   - Monitor API usage and performance
   - Set up error logging

### Common Use Cases

**1. REST API for CRUD operations**:
- Create database table
- Generate default API endpoints
- Add authentication
- Customize response format

**2. Webhook receiver**:
- Create API endpoint to receive webhooks
- Parse incoming payload
- Process data (store, transform, forward)
- Return appropriate response

**3. External API integration**:
- Create function to call external API
- Handle authentication (API keys, OAuth)
- Parse response and transform data
- Store or return processed data

**4. Data transformation pipeline**:
- Query source data
- Apply filters and transformations
- Aggregate or format results
- Return processed data

**5. Scheduled background tasks**:
- Create background task
- Define schedule (cron-like)
- Implement logic (cleanup, notifications, sync)
- Handle errors and retries

### XanoScript Guidelines

**Be mindful of syntax differences**:
- XanoScript is NOT JavaScript/Python
- Function syntax: `namespace.function` (e.g., `db.query`, not `db_query`)
- Variables always use `$` prefix: `$my_variable`
- Assignment uses `as` keyword: `db.query users {} as $users`
- Filters use pipe: `$users|count`, not `count($users)`

**When uncertain about syntax**:
1. Check [docs/xanoscript-reference.md](docs/xanoscript-reference.md) for examples
2. Ask Xano MCP to show existing function examples
3. Test small snippets first
4. Reference official documentation: https://docs.xano.com/xanoscript/key-concepts

**Common XanoScript mistakes**:
- ❌ `db_query("users")` → ✅ `db.query users { }`
- ❌ `var my_var = "value"` → ✅ `var $my_var { value = "value" }`
- ❌ `count($array)` → ✅ `$array|count`
- ❌ `if (condition) {}` → ✅ `conditional { if ($condition) { } }`

### Available MCP Tools

Once the plugin is enabled and environment variables are set, the Xano MCP server provides these tools automatically:

- **Database operations**: Creating and modifying tables, schemas, relationships
- **API development**: Building endpoints, configuring routes and methods
- **Authentication**: Managing API keys, JWT, OAuth configurations
- **Custom functions**: Creating business logic with XanoScript
- **Background tasks**: Setting up scheduled and triggered jobs
- **Documentation**: Generating OpenAPI specs for frontend integration
- **Workspace management**: Configuring settings and permissions

**Using MCP tools**: Simply ask Claude to perform Xano operations naturally (e.g., "Create a users table with email and name fields"). Claude will automatically use the appropriate Xano MCP tools to execute your requests.

### Error Handling

**Common issues**:
- **Authentication errors**: Verify MCP token is correct and has required scopes
- **XanoScript syntax errors**: Check function names, variable syntax, and filter usage
- **Permission errors**: Ensure token has appropriate permissions for operation
- **Rate limiting**: Xano has API rate limits - implement appropriate throttling

**Debugging approach**:
1. Test XanoScript in Xano's visual editor first
2. Validate data types and structure
3. Check API endpoint configuration
4. Review error messages carefully
5. Use Xano's built-in debugger and logs

### Security Best Practices

1. **Token management**:
   - Never commit MCP tokens to version control
   - Use environment variables or secure storage
   - Rotate tokens periodically

2. **API security**:
   - Implement authentication on sensitive endpoints
   - Use API key authentication or JWT
   - Validate and sanitize all inputs
   - Implement rate limiting

3. **Data protection**:
   - Use appropriate field types (encrypted for sensitive data)
   - Implement proper access controls
   - Regular backups before significant changes
   - Test in non-production workspace first

## Examples

### Example 1: Create a Simple User Table and CRUD API

**User request**:
```
I need a backend to store user profiles with name, email, and bio
```

**You would**:
1. Use Xano MCP to create a table:
   - Table name: `users`
   - Fields:
     - `name` (text, required)
     - `email` (text, required, unique)
     - `bio` (text, optional)
     - `created_at` (timestamp, auto)

2. Generate CRUD API endpoints:
   - GET `/users` - List all users
   - GET `/users/{id}` - Get single user
   - POST `/users` - Create user
   - PUT `/users/{id}` - Update user
   - DELETE `/users/{id}` - Delete user

3. Add email validation to POST endpoint using XanoScript:
   ```xanoscript
   conditional {
     if ($email|is_email|not) {
       response.error "Invalid email format"
     }
   }
   ```

4. Test endpoints and return API documentation URLs

### Example 2: Build LinkedIn OAuth Callback Handler

**User request**:
```
Create an endpoint to receive LinkedIn OAuth callback and store the access token
```

**You would**:
1. Create database table:
   - Table name: `oauth_tokens`
   - Fields:
     - `user_id` (text)
     - `provider` (text) - "linkedin"
     - `access_token` (text, encrypted)
     - `refresh_token` (text, encrypted)
     - `expires_at` (timestamp)

2. Create API endpoint:
   - Method: `POST`
   - Path: `/oauth/linkedin/callback`
   - Inputs:
     - `code` (text, required) - OAuth authorization code
     - `user_id` (text, required)

3. Implement function stack logic:
   ```xanoscript
   api oauth_callback {
     input {
       text code filters=required
       text user_id filters=required
     }

     stack {
       // Exchange code for token (would call LinkedIn API)
       http.request {
         url = "https://www.linkedin.com/oauth/v2/accessToken"
         method = "POST"
         body = {
           grant_type: "authorization_code",
           code: $code,
           client_id: env.LINKEDIN_CLIENT_ID,
           client_secret: env.LINKEDIN_CLIENT_SECRET
         }
       } as $token_response

       // Store token in database
       db.insert oauth_tokens {
         user_id = $user_id,
         provider = "linkedin",
         access_token = $token_response.access_token,
         refresh_token = $token_response.refresh_token,
         expires_at = $token_response.expires_in|timestamp_offset
       } as $stored_token

       response = {
         success: true,
         token_id: $stored_token.id
       }
     }
   }
   ```

4. Test the endpoint with sample OAuth code
5. Return endpoint URL and usage instructions

### Example 3: Create Data Transformation Function

**User request**:
```
I need to format user data from the database before sending it to the frontend
```

**You would**:
1. Create custom function:
   - Name: `format_user_data`
   - Purpose: Transform database user records to API response format

2. Implement XanoScript logic:
   ```xanoscript
   function format_user_data {
     input {
       object user_data
     }

     stack {
       // Initialize result variable
       var $formatted {
         value = {}
       }

       // Format timestamp
       var.update $formatted {
         value = $user_data|set:"created_at":($user_data.created_at|format_timestamp:"Y-m-d")
       }

       // Add full name
       var.update $formatted {
         value = $formatted|set:"full_name":($user_data.first_name + " " + $user_data.last_name)
       }

       // Remove sensitive fields
       var.update $formatted {
         value = $formatted|unset:"password_hash"|unset:"internal_notes"
       }

       response = $formatted
     }
   }
   ```

3. Show how to use the function in API endpoint
4. Test with sample data

### Example 4: Webhook Handler for External Service

**User request**:
```
Create a webhook endpoint to receive notifications from Stripe
```

**You would**:
1. Create API endpoint:
   - Method: `POST`
   - Path: `/webhooks/stripe`
   - Authentication: Verify Stripe signature

2. Implement handler logic:
   ```xanoscript
   api stripe_webhook {
     input {
       text event_type
       object data
     }

     stack {
       // Log the webhook event
       db.insert webhook_logs {
         source = "stripe",
         event_type = $event_type,
         payload = $data,
         received_at = timestamp.now
       }

       // Handle different event types
       conditional {
         if ($event_type == "payment_intent.succeeded") {
           // Update order status
           db.update orders {
             where = { stripe_payment_id: $data.id },
             set = { status: "paid", paid_at: timestamp.now }
           }
         }
         elseif ($event_type == "customer.subscription.deleted") {
           // Handle subscription cancellation
           db.update users {
             where = { stripe_customer_id: $data.customer },
             set = { subscription_status: "cancelled" }
           }
         }
       }

       response = { received: true }
     }
   }
   ```

3. Configure Stripe webhook URL
4. Test with Stripe webhook testing tool

### Example 5: Scheduled Background Task

**User request**:
```
Set up a daily task to clean up expired tokens
```

**You would**:
1. Create background task:
   - Name: `cleanup_expired_tokens`
   - Schedule: Daily at 2:00 AM
   - Type: Recurring

2. Implement cleanup logic:
   ```xanoscript
   task cleanup_expired_tokens {
     stack {
       // Get current timestamp
       var $now { value = timestamp.now }

       // Find expired tokens
       db.query oauth_tokens {
         where = {
           expires_at: { $lt: $now }
         }
       } as $expired_tokens

       // Delete expired tokens
       foreach ($expired_tokens) {
         each as $token {
           db.delete oauth_tokens {
             where = { id: $token.id }
           }
         }
       }

       // Log cleanup result
       db.insert task_logs {
         task_name = "cleanup_expired_tokens",
         tokens_deleted = $expired_tokens|count,
         executed_at = $now
       }
     }
   }
   ```

3. Set up task schedule
4. Test task execution manually
5. Monitor task logs

## Summary

This skill enables building complete backend systems using Xano's no-code platform through MCP integration. Create databases, APIs, and business logic using XanoScript - Xano's custom syntax. Always reference the XanoScript documentation when uncertain about syntax, and test incrementally to ensure correct implementation.

**Key Resources**:
- XanoScript Reference: [docs/xanoscript-reference.md](docs/xanoscript-reference.md)
- Official Docs: https://docs.xano.com
- MCP Setup: https://docs.xano.com/building/build-with-ai/xano-mcp
