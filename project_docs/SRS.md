# Software Requirements Specification (SRS)

# 📄 **Software Requirements Specification (SRS)**

### **HR Chatbot Automation System (Leave, Sick Leave, Benefits Claim)**

**Version:** 1.0

**Date:** 2025-11-14

**Prepared for:** น็อต and project stakeholders

**Prepared by:** ChatGPT

---

# **1. Introduction**

## **1.1 Purpose**

This Software Requirements Specification (SRS) describes the functional and non-functional requirements for the **HR Chatbot Automation System** that handles:

- Leave requests (ลากิจ, ลาป่วย, ลาพักร้อน)
- Benefit reimbursements (เบิกสวัสดิการ เช่น ค่ารักษาพยาบาล)
- Viewing leave balances
- Approval workflows (Manager + HR)
- Notifications & document uploads

The system integrates **Chatbot + AI/NLP + n8n automation + Backend + Database**.

---

## **1.2 Document Conventions**

The SRS follows the IEEE 830 standard:

- **“Shall”** indicates a mandatory requirement.
- **“Should”** indicates a recommended feature.
- **“May”** indicates an optional feature.

---

## **1.3 Intended Audience**

- Developers
- Project Managers
- HR Department
- System Integrators
- n8n Workflow Engineers
- QA Testers

---

## **1.4 Project Scope**

The system will:

- Provide a chatbot interface for employees to request HR actions
- Use AI/NLP to understand user messages
- Automate workflows using n8n
- Integrate with internal HR databases or external HR systems
- Provide approval interfaces for managers and HR
- Generate reports

---

# **2. Overall Description**

## **2.1 Product Perspective**

The system acts as a middleware connecting:

- Chat platform (LINE, Web, Slack/Teams)
- AI/NLP for intent understanding
- n8n workflows
- Backend API
- Database & file storage

It may replace or complement existing HR systems.

---

## **2.2 Product Functions**

The system shall provide the following main features:

### **1) Leave Management**

- Request leave
- Validate remaining leave days
- Notify managers
- Approve/reject leave
- View leave history and balance

### **2) Sick Leave**

- Accept sick leave requests
- Accept medical certificate uploads
- Auto-flag if medical certificate is missing

### **3) Benefit Reimbursement**

- Submit reimbursement claims
- Upload proof documents (PDF, image)
- Send for HR approval
- Track status

### **4) Manager Dashboard (via chatbot)**

- View pending approvals
- Approve/reject requests
- Receive notifications

### **5) HR Admin Features**

- Monthly leave report
- View all employees’ leave/benefits
- Edit policies

---

## **2.3 User Classes and Characteristics**

| User Type | Description | Permissions |
| --- | --- | --- |
| **Employee** | All staff using chatbot | Request leave, check balance, upload documents |
| **Manager** | Supervisors who approve | View team requests, approve/reject |
| **HR Staff** | HR admins | Override, manage policies, run reports |
| **System Admin** | IT team | Configure backend, n8n, chatbot |

---

## **2.4 Operating Environment**

- Chat platform: LINE OA, Web, Slack, Teams
- Backend: Node.js or Python (FastAPI)
- Automation: n8n (Self-hosted or Cloud)
- Database: PostgreSQL or MySQL
- Storage: Cloud storage (AWS S3 / MinIO)
- Server: Docker-based deployment

---

## **2.5 Design and Implementation Constraints**

- Must comply with **PDPA** (Thai privacy law)
- Internet connectivity required
- Chat platform message format limitations (e.g., LINE quick replies)
- n8n processing delays must be minimal

---

## **2.6 User Documentation**

The system should include:

- User manual for employees
- Manager approval guide
- HR report guide
- Developer documentation for API
- n8n workflow documentation

---

# **3. System Features (Functional Requirements)**

# **3.1 Leave Request Module**

## **3.1.1 Description**

Employees submit leave through chatbot; system processes and sends approval requests.

### **3.1.2 Functional Requirements**

1. The system **shall detect leave intent** automatically from natural language.
2. The system **shall extract**:
    - Leave type
    - Start date, end date
    - Number of days
3. The system **shall validate leave quota**.
4. The system **shall confirm the request** with the user before submission.
5. The system **shall create a leave record in the database**.
6. The system **shall notify the manager via LINE/Email/Slack**.
7. The system **shall track approval status**.
8. The system **shall notify the employee upon approval/rejection**.

---

# **3.2 Sick Leave Module**

### **Functional Requirements**

1. The system **shall allow sick leave requests without prior notice**.
2. The system **shall ask for a medical certificate upload** when needed.
3. The system **shall attach the document to the leave request record**.
4. The system **shall notify HR if certificate is missing after 48 hours**.

---

# **3.3 Benefit Reimbursement Module**

### **Functional Requirements**

1. The system **shall accept reimbursement requests** (amount + type).
2. The system **shall require supporting documents** (photos, PDFs).
3. The system **shall validate annual allowance**.
4. The system **shall route requests to HR** through n8n.
5. The system **shall track status and notify employees**.

---

# **3.4 Balance Checking Module**

### **Functional Requirements**

1. The system **shall return remaining leave balance** (personal, sick, vacation).
2. The system **shall return remaining benefit quota**.

---

# **3.5 Manager Approval Module**

### **Functional Requirements**

1. The system **shall allow managers to view pending requests**.
2. The system **shall provide Approve/Reject options in the chatbot**.
3. The system **shall require a reason for rejection**.
4. The system **shall log all approval actions**.

---

# **3.6 HR Reporting Module**

### **Functional Requirements**

1. The system **shall generate monthly leave summary reports**.
2. The system **shall allow export to PDF/Excel**.
3. The system **shall allow HR to override any request**.

---

# **4. External Interface Requirements**

## **4.1 User Interface**

### **Chatbot UI**

- Text-based chat
- Quick replies (LINE, Slack, Web)
- Buttons for approval
- Document upload support

---

## **4.2 APIS**

The backend shall provide REST or GraphQL APIs:

- `/leave/create`
- `/leave/status`
- `/leave/balance`
- `/reimbursement/create`
- `/upload/file`
- `/manager/pending`
- `/report/monthly`

---

## **4.3 Hardware Interface**

No special hardware needed. Runs on user’s mobile/PC.

---

## **4.4 Software Interface**

- LINE Messaging API
- Slack API
- Teams Bot API
- PostgreSQL/MySQL
- n8n Webhook

---

# **5. Non-Functional Requirements**

## **5.1 Performance Requirements**

- Chatbot response time **< 2 seconds**
- n8n workflow execution **< 5 seconds**
- System supports **> 1000 concurrent employees**

---

## **5.2 Security Requirements**

- OAuth2 / JWT for authentication
- Role-based access control (RBAC)
- PDPA compliance
- Encrypted file storage
- Audit logs for all changes

---

## **5.3 Reliability Requirements**

- Uptime 99.9%
- Auto backup every 24 hours
- Failover for n8n workflows

---

## **5.4 Maintainability Requirements**

- Modular microservices architecture
- n8n workflows must use clear node grouping and naming
- Logs must be centralized

---

## **5.5 Scalability Requirements**

- Backend and database must support horizontal scaling
- n8n cluster mode recommended

---

# **6. Other Requirements**

- The system should support Thai and English language.
- The chatbot should support emoji and quick actions.
- The system should keep logs for minimum 1 year.

---

# **Appendix A — Glossary**

- **ลากิจ**: Personal leave
- **ลาป่วย**: Sick leave
- **สวัสดิการ**: Employee benefits
- **Workflow**: Automated process in n8n