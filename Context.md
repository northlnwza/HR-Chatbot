# HR Automation Chatbot - Project Context

## 1. Project Overview
**Goal:** Design and build an HR Automation Chatbot using LINE OA, n8n, and AI to handle leave requests and personnel inquiries.
**Developer:** Year 2 Computer Engineering Student, Mahidol University.
**Role of AI Assistant:** Technical Mentor & System Architect (Focus on practical, production-ready advice).

## 2. Tech Stack
*   **Frontend:** LINE Messaging API (Webhook)
*   **Middleware:** n8n (Self-hosted via Docker)
*   **AI Engine:** Google Gemini 1.5 Flash (via API)
*   **Database:** Supabase (PostgreSQL)
*   **Tunneling:** Ngrok (Static Domain)

## 3. Database Schema (PostgreSQL)

### Table: `users`
Stores employee information and leave balances.
| Column | Type | Details |
| :--- | :--- | :--- |
| `user_id` | SERIAL | Primary Key |
| `line_user_id` | VARCHAR | Unique, Indexed |
| `display_name` | VARCHAR | |
| `role` | VARCHAR | 'employee', 'manager', 'hr' |
| `sick_leave_balance` | INT | Days remaining |
| `vacation_leave_balance` | INT | Days remaining |
| `is_active` | BOOLEAN | |

### Table: `leave_requests`
Stores individual leave transactions.
| Column | Type | Details |
| :--- | :--- | :--- |
| `request_id` | SERIAL | Primary Key |
| `user_id` | INT | FK referencing `users(user_id)` |
| `leave_type` | VARCHAR | 'sick', 'vacation', etc. |
| `start_date` | DATE | |
| `end_date` | DATE | |
| `reason` | TEXT | |
| `status` | VARCHAR | 'pending', 'approved', 'rejected' |

### Table: `chat_state`
Manages conversational context for multi-turn interactions.
| Column | Type | Default | Details |
| :--- | :--- | :--- | :--- |
| `line_user_id` | VARCHAR | PK | |
| `current_mode` | VARCHAR | 'idle' | e.g., 'asking_date', 'asking_reason' |
| `draft_data` | JSONB | '{}' | Temporary storage for incomplete requests |
| `last_updated` | TIMESTAMP | NOW() | |

### Sample Data (SQL)
```sql
INSERT INTO users (line_user_id, display_name, role) VALUES 
    ('U1234567890dummy', 'Test Employee', 'employee'),
    ('YOUR_REAL_LINE_ID', 'Manager', 'manager');
```

## 4. Workflow Logic (n8n)

### 4.1 Inbound Message Handler
1.  **Webhook:** Receives message from LINE.
2.  **AI Parsing (Gemini):** Extracts `Intent`, `Type`, `Date`, `Reason`.
3.  **Routing (Switch Node):**
    *   **Leave Request:**
        *   Upsert User (ensure user exists).
        *   **Validation:** Check if `(End Date - Start Date) <= Balance`.
            *   *If Invalid:* Reply "Insufficient Balance".
            *   *If Valid:* Insert into `leave_requests` ('pending') -> Send **Flex Message** to Manager.
    *   **Check Balance:** Query `users` -> Reply with balance info.
    *   **Unknown:** Chit-chat fallback.

### 4.2 Approval Handler
1.  **Trigger:** Manager clicks 'Approve' or 'Reject' in LINE (Postback).
2.  **Update:** Set `leave_requests.status` to new status.
3.  **Notify:** Send confirmation message to the Employee.
4.  **Logic (Pending):** If Approved, deduct days from `users` balance.

### 4.3 Technical Implementation Details (from `workflow.json`)
*   **LLM JSON Schema:** The Gemini node is prompted to output **RAW JSON ONLY** with this structure:
    ```json
    {
      "intent": "leave_request | check_balance | unknown",
      "entities": {
        "type": "sick | vacation | null",
        "start_date": "YYYY-MM-DD",
        "end_date": "YYYY-MM-DD",
        "reason": "string | null"
      }
    }
    ```
*   **Date Calculation:** A JavaScript Code node calculates `duration = (end - start) + 1`.
*   **Postback Data:** The Approval buttons send data in the format: `action=approve&reqId=123`.

## 5. Configuration & Environment
*   **Docker:** `n8n` and `ngrok` run via `docker-compose`.
*   **Database:** Supabase Connection Pooler (Port 6543) with SSL disabled (fixes Docker/IPv6 issues).
*   **Environment Variables (`.env`):**
    *   `NGROK_AUTHTOKEN`
    *   `NGROK_DOMAIN`
    *   `GENERIC_TIMEZONE` (e.g., Asia/Bangkok)
*   **n8n Credentials (Required):**
    *   **Google Gemini(PaLM) Api:** For Intent Parsing & Chit-chat.
    *   **Line Messaging Api:** For sending replies and Flex messages.
    *   **Postgres:** For connecting to Supabase.
    *   **Groq Api:** Used in some alternative Chat Model nodes (check if active).

## 6. Current Status & Roadmap

### Completed ✅
*   [x] Database Persistence (Leave Requests).
*   [x] Manager Notification (Interactive Flex Messages).
*   [x] Approval Workflow (Handle Approve/Reject postbacks).
*   [x] Basic Validation (Prevent requests exceeding balance).
*   [x] AI Integration (Intent/Entity Extraction).

### Known Issues / Anomalies ⚠️
*   **Disconnected Node:** The `Notify to Manager` node (Flex Message) appears to be disconnected in the current `workflow.json`. It typically should follow the `Success Request MSG` node.

### Next Steps 🚀
1.  **Approval Logic:** Implement SQL transaction to deduct balance when status becomes 'approved'.
2.  **Deployment:** Move from local Ngrok tunnel to cloud hosting (e.g., Render, Railway, or VPS).
3.  **Refinement:** Improve error handling and user feedback loops.
