# 🚀 Project Pitch: AI-Powered HR Automation Chatbot

## 1. The Hook (One-Liner)
**"We are replacing clunky HR portals with an intelligent assistant that lives where your employees already are."**

An AI-driven chatbot that automates leave requests, balance checks, and approvals directly through LINE, powered by Google Gemini and n8n.

---

## 2. The Problem
Traditional HR Information Systems (HRIS) suffer from high friction:
*   **Complex Portals:** Employees forget passwords and navigate confusing menus just to book a sick day.
*   **Manual Data Entry:** HR spends hours manually updating spreadsheets or calendars.
*   **Delayed Approvals:** Requests get lost in email inboxes, frustrating employees.
*   **Lack of Visibility:** Managers don't know who is off today without logging into a separate system.

## 3. The Solution
**The HR Chatbot** streamlines these processes into a simple conversation.
*   **Natural Language:** Employees just say, "I'm taking sick leave tomorrow" or "Who is off today?"
*   **Instant Validation:** The system checks leave balances and policies in real-time.
*   **Automated Workflow:** Managers get a "Approve/Reject" button in their chat.
*   **Seamless Sync:** Approved leaves automatically appear on the company Google Calendar.

---

## 4. Key Features
### 🗣️ Natural Language Processing (NLP)
*   Understands Thai and English.
*   Detects intents: Leave Requests, Balance Checks, Team Schedule Queries.
*   Extracts dates, reasons, and leave types automatically.

### ⚡ Smart Automation
*   **Leave Requests:** Validates quota $\rightarrow$ Creates DB record $\rightarrow$ Notifies Manager.
*   **Approvals:** One-click approval triggers notifications and calendar updates.
*   **Calendar Integration:** Automatically syncs approved leave to Google Calendar.
*   **Role-Based Access:** Distinct capabilities for Employees vs. Managers.

### 🔒 Enterprise-Grade Infrastructure
*   **Self-Hosted:** Full control over data using Docker.
*   **Secure:** Built on PostgreSQL (Supabase) with Role-Based Access Control.
*   **Scalable:** Microservices architecture using n8n for workflow orchestration.

---

## 5. Technical Architecture (The "Stack")
We utilize a modern, decoupled tech stack designed for speed and flexibility:

| Component | Technology | Why we chose it |
| :--- | :--- | :--- |
| **Brain (AI)** | **Google Gemini 1.5 Flash** | Fast, cost-effective, and excellent at Thai NLP. |
| **Orchestrator** | **n8n** | Powerful visual workflow automation; easy to modify logic without code. |
| **Interface** | **LINE Messaging API** | Ubiquitous usage in Thailand; zero learning curve for users. |
| **Database** | **PostgreSQL (Supabase)** | Robust relational data storage with JSON support. |
| **Infrastructure** | **Docker & Ngrok** | Portable, secure, and easy to deploy anywhere. |

---

## 6. Current Progress (Jan 2026)
**Overall Completion: ~35%**

*   ✅ **Infrastructure:** Fully operational Docker environment with n8n and Database.
*   ✅ **Database Schema:** Core tables (`users`, `leave_requests`, `leave_calendar`) deployed.
*   ✅ **AI Brain:** Gemini is successfully parsing intents and extracting entities.
*   ✅ **Calendar Logic:** Database design handles leave expansion (multi-day) and team availability queries.
*   🚧 **Next Step:** Connecting the n8n logic to finalized database actions (Insert/Update).

---

## 7. Roadmap
*   **Phase 1 (Now):** Finalize "Leave Request" transaction logic.
*   **Phase 2:** Implement "Manager Approval" interactive messages.
*   **Phase 3:** Add "Reimbursement" module for expense claims (OCR for receipts).
*   **Phase 4:** Build a Web Dashboard for HR Analytics and detailed reporting.

---

## 8. Value Proposition
*   **For HR:** Reduces administrative overhead by 60%.
*   **For Managers:** Instant visibility into team availability.
*   **For Employees:** Zero friction; requests take seconds, not minutes.

---
*Generated on January 4, 2026*
