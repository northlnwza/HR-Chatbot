# HR Automation Chatbot

This project describes an HR Automation Chatbot developed by a Year 2 Computer Engineering Student at Mahidol University.

## Tech Stack

*   **Frontend**: LINE Messaging API (Webhook)
*   **Middleware**: n8n (Self-hosted via Docker)
*   **AI Engine**: Google Gemini 1.5 Flash (via API)
*   **Database**: Supabase (PostgreSQL)
*   **Tunneling**: Ngrok (Static Domain)

## Database Schema (PostgreSQL)

### Table 'users'

*   `user_id` (SERIAL PK)
*   `line_user_id` (VARCHAR UNIQUE)
*   `display_name`
*   `role`
*   `sick_leave_balance` (INT)
*   `vacation_leave_balance` (INT)
*   `is_active` (BOOL)

### Table 'leave_requests'

*   `request_id` (SERIAL PK)
*   `user_id` (FK to users)
*   `leave_type`
*   `start_date`
*   `end_date`
*   `reason`
*   `status`

## Workflow Logic (n8n)

1.  Webhook receives LINE message.
2.  Google Gemini AI parses text into JSON (Intent, Type, Date, Reason).
3.  Switch Node routes based on intent (currently 'leave_request').
4.  Postgres Node 1 (Get/Create User): Uses raw SQL with `ON CONFLICT DO UPDATE` to handle new vs existing users efficiently.
5.  Postgres Node 2 (Insert Request): Inserts the leave request using the ID from Node 1 and data from AI.
6.  LINE Node sends a confirmation reply to the user.

## Configuration Details

*   Running via `docker-compose` with 'n8n' and 'ngrok' services.
*   Secrets (Ngrok Token, Domain, Timezone) stored in `.env` file (not git committed).
*   Supabase Connection: Uses Transaction Pooler (Port 6543) with SSL disabled to resolve Docker/IPv6 connection issues.

## Current Status

The 'Happy Path' for sick leave is complete, with data saving to the database. Next steps involve handling 'Unknown' intents (chit-chat) and 'Check Balance' intents.
