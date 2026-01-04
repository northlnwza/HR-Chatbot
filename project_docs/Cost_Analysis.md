# 💰 Project Cost Analysis
*Estimated operational costs for the HR Chatbot Pipeline.*

## 1. Cost Breakdown by Component

| Component | Service Provider | Pricing Model | Monthly Cost (Est.) |
| :--- | :--- | :--- | :--- |
| **Frontend** | **LINE OA (Thailand)** | Message-based | **0 - 1,280 THB** |
| **AI Brain** | **Google Gemini 1.5 Flash** | Usage-based | **$0.00** |
| **Database** | **Supabase (PostgreSQL)** | Tiered | **$0 - $25.00** |
| **Orchestrator**| **n8n (Self-Hosted)** | Free License | **$0.00** |
| **Infrastructure**| **Hosting (VPS)** | Fixed (e.g., DigitalOcean) | **$6.00** |
| **Tunneling** | **Ngrok** | Static Domain | **$0 - $10.00** |

---

## 2. Cost Scenarios

### 🟢 Scenario A: "The Free Tier" (Development & Testing)
*Best for: Prototyping, Demoing to stakeholders.*

*   **LINE:** Free (Max 300 Push messages/month. Replies are free).
*   **Gemini:** Free Tier (15 requests/minute is plenty for testing).
*   **Supabase:** Free (Note: Pauses after 7 days of inactivity).
*   **n8n:** Self-Hosted on local PC.
*   **Tunneling:** Ngrok Free (Random URL changes every restart).
*   **Total:** **$0.00 / month**

### 🟡 Scenario B: "Stable MVP" (Small Team < 20 Employees)
*Best for: Internal usage, reliable uptime, fixed webhooks.*

*   **Infrastructure:** Move from Local PC $\rightarrow$ **Cloud VPS** (e.g., DigitalOcean Droplet, 1GB RAM) to run Docker 24/7. (**~$6/month**)
*   **Database:** Upgrade Supabase to **Pro** to prevent database "pausing" and enable daily backups. (**$25/month**)
*   **LINE:** Stay on **Free Tier** (Replies don't count towards quota; only Notifications to Managers do).
*   **Gemini:** Still within Free Tier limits.
*   **Total:** **~$31.00 / month** (~1,050 THB)

### 🔴 Scenario C: "Production Scale" (Medium Company > 50 Employees)
*Best for: High volume of requests, many notifications, critical reliability.*

*   **Infrastructure:** Larger VPS (4GB RAM) for smoother n8n performance. (**~$24/month**)
*   **LINE:** Upgrade to **Basic Plan** (15,000 messages) to send broadcast announcements and notifications without limits. (**~1,280 THB $\approx$ $38**)
*   **Database:** Supabase Pro. (**$25**)
*   **AI:** Gemini Pay-As-You-Go (Costs are negligible unless millions of tokens used, e.g., < **$5**).
*   **Total:** **~$92.00 / month** (~3,100 THB)

---

## 3. Important Details

### 📱 LINE Messaging API Costs
*   **Reply Messages:** (User types $\rightarrow$ Bot replies) are **FREE** on all plans.
*   **Push Messages:** (Bot initiates conversation, e.g., "Manager, you have a request") count towards the quota.
*   **Recommendation:** Use the Free tier as long as possible. Only upgrade if you send >300 "Notification" messages per month.

### 🧠 Google Gemini Costs
*   **1.5 Flash Model:** Extremely cheap ($0.0375 / 1M input tokens).
*   **Example:** A typical leave request is ~200 tokens. You can process **5,000 requests for ~$0.04**.
*   **Verdict:** AI cost is effectively zero for this project scale.

### 🗄️ Database (Supabase)
*   **The "Pause" Risk:** The Free tier pauses your database if no one uses it for 7 days. This breaks the bot until you manually wake it up.
*   **Solution:** For production, the $25/month Pro plan is the safety tax to ensure 99.9% uptime.
