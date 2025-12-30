# HR Chatbot

- Journey
    
    # 📌 **1. User Journey Scenarios**
    
    - **Scenario A — Request Personal Leave (ลากิจ)**
        
        ## ▶️ **Scenario A — Request Personal Leave (ลากิจ)**
        
        **User:**
        
        > ทำเรื่องลา ลากิจ 2 วัน ตั้งแต่ 15–16 พ.ย.
        > 
        
        **Chatbot Flow:**
        
        - Detect intent → *Request Leave*
        - Extract → *ลากิจ*, 2 days, 15–16 Nov
        - Validate → leave balance, date conflicts
        - Confirm with user
        - If user confirms →
            - Create leave record
            - Notify manager
            - Log request
        - **Bot:**
            
            > ✔️ ส่งคำขอให้หัวหน้าแล้ว รอการอนุมัติ
            > 
    - **Scenario B — Sick Leave (ลาป่วย)**
        
        ## ▶️ **Scenario B — Sick Leave (ลาป่วย)**
        
        **User:**
        
        > ลาป่วยวันนี้ ไข้ขึ้นมาก
        > 
        
        **Chatbot Flow:**
        
        - Detect → Sick leave
        - Extract → Today
        - Request medical certificate (if needed)
        - Submit request
        - Notify manager + HR
        
        ---
        
    - **Scenario C — Benefit Reimbursement (เบิกสวัสดิการ)**
        
        ## ▶️ **Scenario C — Benefit Reimbursement (เบิกสวัสดิการ)**
        
        **User:**
        
        > อยากเบิกค่ารักษาพยาบาล 1,500 บาท
        > 
        
        **Chatbot Flow:**
        
        - Intent → Reimbursement
        - Extract → 1,500 THB, medical category
        - Ask for receipt upload
        - Validate annual benefit quota
        - Create reimbursement request
        - Notify user when processed
        
        ---
        
    - **Scenario D — Checking Leave Balance**
        
        ---
        
        ## ▶️ **Scenario D — Checking Leave Balance**
        
        **User:**
        
        > ตอนนี้มีวันลาคงเหลือกี่วัน?
        > 
        
        **Chatbot Flow:**
        
        - Query leave balance
        - **Bot:**
            - ลากิจ: 1 วัน
            - ลาป่วย: 20 วัน
            - ลาพักร้อน: 5 วัน
        
        ---
        
    - **Scenario E — Manager View (Approvals)**
        
        ## ▶️ **Scenario E — Manager View (Approvals)**
        
        **User:**
        
        > มีใครรออนุมัติลาบ้าง?
        > 
        
        **Chatbot Flow:**
        
        - List pending requests
        - Show Approve/Reject
        - Update database
        - Notify employees
        
        ---
        
    - **Scenario F — HR Tools**
        
        ## ▶️ **Scenario F — HR Tools**
        
        **User (HR):**
        
        > ดูรายงานลารายเดือน
        > 
        
        **Chatbot Flow:**
        
        - Generate monthly report
        - Provide download link (PDF/Excel)
    
    # 📌 **2. Functional Requirements**
    
    ## **A. Chatbot Capabilities**
    
    - Understand leave requests
    - Understand reimbursement requests
    - Extract dates, days, amounts, categories
    - Provide confirmations
    - Allow modification or cancellation
    - Answer balance/status queries
    
    ---
    
    ## **B. Leave Management**
    
    - Create leave requests
    - Validate policy (quota, weekends, holidays)
    - Multi-level approval workflow
    - File upload for medical certificate
    - Notifications for manager & employee
    
    ---
    
    ## **C. Reimbursements**
    
    - Create reimbursement requests
    - Validate eligibility
    - Require document uploads
    - Multi-level approval
    - Integrate with accounting/HR
    
    ---
    
    ## **D. Employee Services**
    
    - Leave balance
    - Benefit balance
    - Document downloads (payroll, tax)
    
    ---
    
    # 📌 **3. System Architecture (High-Level)**
    
    ## **Layers**
    
    ### **1. Chat Interface**
    
    - LINE OA
    - Web Chat widget
    - Teams / Slack Bot
    
    ### **2. NLP / Chatbot Brain**
    
    - OpenAI GPT
    - OR Rasa/Dialogflow
    - Entity extraction + intent classification
    
    ### **3. Automation Layer (n8n)**
    
    Handles:
    
    - Workflow automation
    - Approvals
    - Notifications
    - File processing
    - Database updates
    - Scheduled reports
    
    ### **4. Backend**
    
    Responsible for:
    
    - Authentication
    - API endpoints
    - Employee data
    - Leave database
    - Benefits database
    - File storage
    
    ### **5. Storage**
    
    - PostgreSQL or MySQL
    - S3/Google Drive for files
    
    ---
    
    # 📌 **4. n8n Workflow Examples**
    
    ### **Workflow 1 — Leave Request**
    
    1. Trigger (chat webhook)
    2. Parse → detect leave type + dates
    3. Validate leave quota
    4. Create request in DB
    5. Notify manager
    6. Wait for approval event
    7. Update status
    8. Notify employee
    
    ---
    
    ### **Workflow 2 — Reimbursement**
    
    1. Trigger
    2. Extract amount + category
    3. Request document upload
    4. Validate benefit quota
    5. Create claim
    6. Notify HR
    7. Update status
    
    ---
    
    ### **Workflow 3 — Balance Check**
    
    1. Trigger
    2. Query DB
    3. Return formatted summary
    
    ---
    
    ### **Workflow 4 — Manager Approval**
    
    1. Manager clicks approve/reject
    2. Update request status
    3. Notify employee
    4. Log audit event
    
    ---
    
    # 📌 **5. Database (ERD Overview)**
    
    - **Employees**
        - id, name, email, role, manager_id
    - **LeaveTypes**
        - id, name, quota
    - **LeaveRequests**
        - id, employee_id, type, start_date, end_date, status
    - **BenefitCategories**
        - id, name, yearly_limit
    - **ReimbursementRequests**
        - id, employee_id, category_id, amount, file_url, status
    - **Approvals**
        - id, request_id, approver_id, action, timestamp
    
    ---
    
    # 📌 **6. Tech Stack Summary**
    
    ### 🧠 **AI/NLP**
    
    - OpenAI GPT
    - Rasa (optional)
    - HuggingFace models (optional)
    
    ### ⚙️ **Automation**
    
    - **n8n (core of workflow logic)**
    
    ### 🏗 **Backend**
    
    - Node.js (Express / NestJS)
    - Python (FastAPI / Django)
    - Go (optional, high performance)
    
    ### 🗄 **Database**
    
    - PostgreSQL (recommended)
    - MySQL
    - MongoDB (less ideal for HR)
    
    ### 📦 **Storage**
    
    - S3 / MinIO
    - Google Drive (via n8n)
    
    ### 🔗 **Integrations**
    
    - LINE Messaging API
    - Slack / Teams
    - Email (SMTP/Gmail)
    - Internal HR/Payroll API
    
    ---
    
    # 📌 **7. Non-Functional Requirements**
    
    - PDPA-compliant
    - Secure authentication (OAuth2/JWT)
    - Role-based access (Employee/Manager/HR)
    - Audit logs
    - <2s response time
    - 99.9% uptime
    - Backup + disaster recovery

When a leave request is approved, expand it into daily entries:

Example:
Request = 15–17 Nov → create 3 rows.

# ⚙️ **2. n8n Workflow Integration**

### When a leave request gets **approved**, n8n will:

1. Retrieve start_date and end_date
2. Generate date range
3. Insert each date into `LeaveCalendar`
4. Notify HR/Manager
5. Trigger “Calendar Updated” event (optional)

### When a leave request gets **cancelled**:

- Remove corresponding entries from LeaveCalendar

### When HR overrides:

- Same steps as above

---

# 💬 **3. Chatbot Features (Natural Language Commands)**

### **User can ask:**

- “วันนี้ใครลา?”
- “พรุ่งนี้มีใครลาบ้าง?”
- “สัปดาห์นี้ของทีมผมมีคนลามั้ย?”
- “ปฏิทินลาประจำเดือน”
- “แผนก A มีใครลาบ้างเดือนนี้?”

### **Responses will look like:**

**วันนี้ (14 ธ.ค.) มี 3 คนลางาน:**

- คุณกิตติ – ลาป่วย
- คุณแนน – ลากิจ
- คุณธวัช – ลาพักร้อน

or

**แผนก Software – สัปดาห์นี้ (12–18 ธ.ค.)**

- จันทร์: A, B ลาป่วย
- พฤหัส: C ลากิจ

---

# 🖥 **4. Manager Dashboard Feature (Optional)**

### Calendar view

- Day (who is off today)
- Week (team availability)
- Month (HR overview)

### Filters

- Department
- Leave type
- Status
- Employee

Could be a simple web UI or a mobile-friendly page.

---

# 📆 **5. Integration with External Calendars (Optional but Powerful)**

You can sync approved leave to:

- Google Calendar
- Outlook Calendar
- Shared team calendar

### n8n can handle integrations:

- “When leave approved → Create calendar event”

---

# 📌 **6. Add to SRS (New Section)**

### **3.7 Leave Calendar Module**

### **Description**

The system provides a calendar interface and API to display employee leave on any date. This module also facilitates quick queries about team availability and integrates with approval workflows to maintain up-to-date leave schedules.

### **Functional Requirements**

1. The system **shall record each approved leave day** into a daily calendar table.
    *   **Clarification:** The system **should only record working days** as leave days in the calendar. Weekends and official public holidays that fall within an approved leave range should be filtered out by the system when populating the calendar.
2. The system **shall allow querying** leave by:
    - specific date
    - date range
    - team/department
    - leave type
3. The chatbot **shall respond to natural queries** like “วันนี้ใครลา” or "สัปดาห์นี้มีใครลาบ้าง".
4. The system **shall allow HR and Managers to view team leave calendars** (daily, weekly, monthly views).
    *   **UI/UX:** For chatbot responses, consider using **LINE Flex Messages** for a structured, visually appealing display of leave schedules, rather than plain text lists.
5. The system **shall update the calendar automatically** when:
    - leave approved (expanding multi-day requests into individual daily entries, filtering non-working days)
    - leave cancelled (removing corresponding entries)
    - leave modified (updating relevant entries)
    *   **Data Integrity:** All updates (approve, cancel, modify) to `LeaveCalendar` **must be synchronized** with `LeaveRequests` to prevent data inconsistencies. Operations like cancellation should remove associated `LeaveCalendar` entries.
6. The system **may sync with external calendars** (Google/Outlook) for approved leaves.
7. The system **shall restrict visibility** based on permission level:
    - Employee: Show only their own leave details or anonymized team availability.
    - Manager: View leave for their direct reports/team.
    - HR: View all employee leave.

---

# 🗂 **7. Database ERD Update**

The database schema will be updated to include a `LeaveCalendar` table.

- Employees
- LeaveRequests
- **LeaveCalendar** ← NEW
    - This table will store each individual day an employee is on leave, derived from approved `LeaveRequests`.
    - It allows for:
        - Fast day-based queries ("Who is off today?")
        - Generating weekly/monthly schedules
        - Analyzing team availability
    - **Schema Recommendation:**
        ```sql
        CREATE TABLE leave_calendar (
            id SERIAL PRIMARY KEY,
            request_id INT REFERENCES leave_requests(request_id) ON DELETE CASCADE,
            employee_id INT REFERENCES users(user_id) ON DELETE RESTRICT,
            date DATE NOT NULL,
            leave_type VARCHAR(50), -- Denormalized for faster read queries (sick, vacation, etc.)
            UNIQUE (employee_id, date) -- Ensures an employee cannot be on multiple types of leave on the same day
        );
        ```
- Approvals
- Departments (optional)

---

# 🧠 **8. Example n8n Workflow — “Create Calendar Entries”**

**Trigger:** LeaveRequest.status == “approved”

### Nodes:

1. **Webhook → Parse Leave Data**
2. **Function Node → Generate Date Range**
3. **Database Node → Insert rows into LeaveCalendar**
4. **Condition Node → if external calendar sync enabled**
5. **Google Calendar Node → Create event**
6. **Notification Node → Notify manager/employee**

[Software Requirements Specification (SRS)](project_docs/SRS.md)

[**Project Timeline**](project_docs/Project_Timeline.md)