<div align="center">
  
# 🤖 AI-Powered HR Automation Chatbot

<p>
  An intelligent HR assistant that understands and processes leave requests in natural language. Built with a powerful, self-hosted stack using n8n, Google Gemini, and Docker.
</p>

<!-- Badges -->
<p>
  <a href="https://n8n.io/" target="_blank"><img src="https://img.shields.io/badge/n8n-FFD54F?style=for-the-badge&logo=n8n&logoColor=black" alt="n8n"/></a>
  <a href="https://ai.google.dev/" target="_blank"><img src="https://img.shields.io/badge/Google%20Gemini-8E75B9?style=for-the-badge&logo=google&logoColor=white" alt="Google Gemini"/></a>
  <a href="https://developers.line.biz/en/" target="_blank"><img src="https://img.shields.io/badge/LINE-00C300?style=for-the-badge&logo=line&logoColor=white" alt="LINE"/></a>
  <a href="https://supabase.com/" target="_blank"><img src="https://img.shields.io/badge/Supabase-3FCF8E?style=for-the-badge&logo=supabase&logoColor=white" alt="Supabase"/></a>
  <a href="https://www.postgresql.org/" target="_blank"><img src="https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL"/></a>
  <a href="https://www.docker.com/" target="_blank"><img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker"/></a>
  <a href="https://ngrok.com/" target="_blank"><img src="https://img.shields.io/badge/Ngrok-0055DA?style=for-the-badge&logo=ngrok&logoColor=white" alt="Ngrok"/></a>
</p>

</div>

---

## ✨ Features

*   **Natural Language Processing:** Understands user messages to identify intents like "sick leave" or "check balance".
*   **Automated Data Handling:** Parses dates, reasons, and leave types, then automatically saves them to the database.
*   **Real-time Confirmation:** Instantly notifies users on LINE after their request has been processed.
*   **Scalable Workflow:** Built on n8n for easy customization and addition of new HR tasks.
*   **Self-Hosted:** Full control over your data and infrastructure using Docker.

---

## 🛠️ Tech Stack & Architecture

This project uses a modern, decoupled architecture:

*   **Frontend:** [LINE Messaging API](https://developers.line.biz/en/) serves as the user interface.
*   **Tunneling:** [Ngrok](https://ngrok.com/) provides a secure public URL to expose the local n8n instance to the LINE webhook.
*   **Orchestration:** [n8n](https://n8n.io/) is the core engine that runs the workflow, connecting all services.
*   **AI Engine:** [Google Gemini](https://ai.google.dev/) parses user messages and extracts structured data (JSON).
*   **Database:** [Supabase](https://supabase.com/) (with PostgreSQL) stores all user and leave request data.
*   **Containerization:** [Docker](https://www.docker.com/) and Docker Compose manage the n8n and Ngrok services.

```
User (LINE App) <--> LINE API <--> Ngrok Tunnel <--> n8n Webhook --> Gemini API (for NLP)
                                                                    |
                                                                    +--> Supabase/Postgres (to store data)
                                                                    |
                                                                    +--> LINE API (to send reply)
```

---

## 🚀 Getting Started

Follow these steps to get your own instance of the HR Chatbot running.

### 📋 Prerequisites

*   [Docker Desktop](https://www.docker.com/products/docker-desktop/) installed and running.
*   [Git](https://git-scm.com/) for cloning the repository.
*   A code editor like [VS Code](https://code.visualstudio.com/).
*   API keys and credentials from:
    *   **Google AI Studio:** For Gemini API.
    *   **LINE Developers Console:** Channel Access Token & Channel Secret.
    *   **Supabase:** Database connection details (Host, User, Password).
    *   **Ngrok:** Authtoken and a static domain (available on free plans).

### ⚙️ Step 1: Clone & Configure

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/YOUR_USERNAME/HR-Chatbot.git
    cd HR-Chatbot
    ```

2.  **Create the Environment File:**
    Duplicate the `.env.example` file and rename it to `.env`. Then, fill in your credentials.

    ```bash
    cp .env.example .env
    ```

    **File: `.env`**
    ```env
    # .env - Your secrets go here
    # ⚠️ Do not commit this file to version control!

    # --- Ngrok Configuration ---
    # Get these from your Ngrok dashboard
    NGROK_AUTHTOKEN=YOUR_NGROK_AUTHTOKEN
    NGROK_DOMAIN=YOUR_STATIC_DOMAIN.ngrok-free.dev

    # --- n8n Settings ---
    # Timezone for n8n environment
    GENERIC_TIMEZONE=Asia/Bangkok
    SUBDOMAIN=n8n
    DOMAIN_NAME=localhost
    ```

### 🐳 Step 2: Launch the Services

Run the following command to build and start the n8n and Ngrok containers in the background.

```bash
docker-compose up -d
```

Your services are now running!
*   **n8n instance:** `http://localhost:5678`
*   **Ngrok dashboard:** `http://localhost:4040` (for inspecting traffic)

### 🔗 Step 3: Set Up the n8n Workflow

1.  **Access n8n:** Open `http://localhost:5678` in your browser and create your admin account.

2.  **Import the Workflow:**
    *   From the n8n canvas, click **Import from File**.
    *   Select the `workflows/workflow.json` file from the project directory.

3.  **Connect Your Credentials:**
    The workflow is imported, but you need to connect your accounts. Find the following nodes and add your credentials:
    *   **`Respond to Webhook` (Gemini Node):**
        *   In the `Credential for Google AI` field, select `Create New`.
        *   Enter your Google Gemini API Key.
    *   **`Reply to user` (LINE Node):**
        *   In the `Credential for LINE` field, select `Create New`.
        *   Enter your LINE Channel Secret and Channel Access Token.
    *   **`Get/Create User` (Postgres Node):**
        *   In the `Credential for PostgreSQL` field, select `Create New`.
        *   Use your **Supabase Transaction Pooler** details (Port `6543`) to avoid connection issues inside Docker.
            *   **Host:** `[your-project].pooler.supabase.com`
            *   **Port:** `6543`
            *   **Database:** `postgres`
            *   **User/Password:** Your Supabase DB credentials.
            *   **SSL:** `Allow / No SSL`

4.  **Activate the Workflow:**
    Click the **Active** toggle at the top right of the screen to turn your workflow on. It should be green.

### 🗄️ Step 4: Set Up the Database Schema

1.  **Go to your Supabase project** and open the **SQL Editor**.
2.  Copy the content of `database/init.sql` and run it to create the necessary tables.

    <details>
    <summary>Click to view SQL Schema</summary>

    ```sql
    -- Creates the 'users' table to store information about each LINE user.
    CREATE TABLE users (
        user_id SERIAL PRIMARY KEY,
        line_user_id VARCHAR(255) UNIQUE NOT NULL,
        display_name VARCHAR(255),
        role VARCHAR(50) DEFAULT 'employee',
        sick_leave_balance INT DEFAULT 30,
        vacation_leave_balance INT DEFAULT 10,
        is_active BOOLEAN DEFAULT TRUE,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );

    -- Creates the 'leave_requests' table to log all leave submissions.
    CREATE TABLE leave_requests (
        request_id SERIAL PRIMARY KEY,
        user_id INT REFERENCES users(user_id) ON DELETE RESTRICT,
        leave_type VARCHAR(50) NOT NULL,
        start_date DATE NOT NULL,
        end_date DATE NOT NULL,
        reason TEXT,
        status VARCHAR(50) DEFAULT 'pending',
        manager_comment TEXT,
        created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    );
    ```
    </details>

### ✅ Step 5: Final Webhook Configuration

1.  Go to your **LINE Developers Console**.
2.  Select your channel and go to the **Messaging API** tab.
3.  In the **Webhook URL** field, enter your Ngrok static domain from the `.env` file. It must be a `https` URL and include the `/webhook` path.
    ```
    https://YOUR_STATIC_DOMAIN.ngrok-free.dev/webhook
    ```
4.  Click **Verify** and ensure you see a success message. Enable **"Use webhook"**.

**Congratulations! Your HR Chatbot is now live.** Send a message like "I need to take sick leave tomorrow" from your LINE app to test it.

---

## 🐛 Troubleshooting

*   **Bot doesn't reply?**
    *   Check the Ngrok dashboard (`http://localhost:4040`) to see if requests are coming in.
    *   In n8n, go to **Executions** to see if the workflow ran and check for errors.
    *   Ensure the workflow is **Active**.
*   **Supabase Connection Error?**
    *   Double-check that you are using the **Pooler** port (`6543`), not the standard one (`5432`).
    *   Ensure SSL is disabled in the n8n credential settings.
*   **LINE "Invalid Reply Token"?**
    *   This happens if the workflow takes too long or if you try to manually re-run the "Reply" node. You must trigger the flow with a new message from LINE.

---

## 👨‍💻 Author

*   **Thanakrit Jomhong**
*   *Computer Engineering Student, Mahidol University*
*   [GitHub](https://github.com/Krothorne) | [LinkedIn](https://www.linkedin.com/in/thanakrit-jomhong-8b600034b/)

Give a ⭐️ if this project helped you!