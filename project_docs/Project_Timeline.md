# Project Timeline

# 📅 **Project Timeline (12 Weeks)**

### *HR Chatbot Automation System (with n8n)*

Time estimate: **8–12 weeks** depending on team size.

---

# 🟦 **Phase 1 — Requirements & Planning (Week 1–2)**

### **Activities**

- Kickoff meeting
- Gather HR policies
- Define chatbot channels (LINE, Web)
- Define workflows (ลา, ลาป่วย, เบิกสวัสดิการ)
- Define database entities
- Define integration points (HR system, email, storage)
- Create SRS (done!)
- Approve system architecture

### **Deliverables**

- Requirements Document (SRS)
- Architecture Diagram
- Workflow Specifications
- ERD Schema

### **Milestones**

- **M1: Requirements Approved**
- **M2: Architecture & ERD Finalized**

---

# 🟦 **Phase 2 — System Design (Week 2–3)**

### **Activities**

- Design conversation flows
- Design UX for chatbot (quick replies, buttons)
- Define API endpoints
- Design n8n workflow diagrams
- Choose NLP engine (GPT / Rasa)
- Setup dev environments

### **Deliverables**

- Chat conversation flow specs
- API design document
- n8n workflow maps
- Mock UI screens (optional)

### **Milestones**

- **M3: All Designs Approved**

---

# 🟦 **Phase 3 — Backend Development (Week 3–6)**

### **Activities**

- Build Employee, Leave, Reimbursement services
- Implement REST API
- Build Authentication (JWT/OAuth2)
- Setup PostgreSQL / MySQL
- Setup file uploads (S3 or Drive)
- Implement notification service (email/LINE)

### **Deliverables**

- Backend server (Node.js/FastAPI)
- Database schema migrated
- API endpoints fully functional

### **Milestones**

- **M4: Core Backend Completed (Leave + Auth)**
- **M5: Database Connected + Stable**

---

# 🟦 **Phase 4 — Chatbot & NLP Development (Week 4–7)**

### **Activities**

- Integrate LINE Messaging API or Web chat
- Implement NLP intent detection:
    - ลากิจ
    - ลาป่วย
    - เบิกสวัสดิการ
- Extract entities (dates, days, amounts)
- Build chatbot greeting + help commands
- Test Thai language understanding

### **Deliverables**

- Chatbot message handling
- NLP classification model
- Intent entity extractor

### **Milestones**

- **M6: Chatbot → Backend connection working**
- **M7: NLP for Leave & Reimbursement 95% accuracy**

---

# 🟦 **Phase 5 — n8n Automation Workflows (Week 5–8)**

### **Activities**

Build major workflows:

1. **Leave Request Workflow**
2. **Sick Leave Workflow**
3. **Reimbursement Workflow**
4. **Manager Approval Workflow**
5. **HR Monthly Report Workflow**

### **Deliverables**

- 5+ n8n flows
- n8n triggers & webhooks
- Slack/LINE notification nodes
- Approval decision tree

### **Milestones**

- **M8: All Leave/Reimbursement Workflows Built**
- **M9: Approval Workflow Tested**

---

# 🟦 **Phase 6 — Frontend Chat Interface (Week 7–9)**

*(Only needed if using Web chat. LINE bots skip UI building.)*

### **Activities**

- Build chat widget (React)
- Connect to chatbot backend
- Support file uploads
- Add approval interface for managers

### **Deliverables**

- Web chat widget
- Inbox-style message UI
- Manager approval pop-ups

### **Milestones**

- **M10: Chat UI Fully Integrated**

---

# 🟦 **Phase 7 — Testing & QA (Week 8–10)**

### **Activities**

- Unit tests (backend + NLP)
- Integration tests (chatbot → n8n → DB)
- Thai language message variations
- HR policy validation tests
- Performance testing
- PDPA compliance testing

### **Deliverables**

- Test report
- Issue list
- Final QA checklist

### **Milestones**

- **M11: Internal QA Passed**
- **M12: UAT with HR Completed**

---

# 🟦 **Phase 8 — Deployment & Release (Week 10–12)**

### **Activities**

- Deploy backend (Docker)
- Deploy n8n (container)
- Deploy chatbot (LINE production channel)
- Train HR team
- Final polish

### **Deliverables**

- Production system live
- Admin documentation
- Training session recordings

### **Milestones**

- **M13: Production Deployment Completed**
- **M14: Project Sign-Off**

---

# 📊 **High-Level Timeline (Gantt-Style Summary)**

```
Week:     1 2 3 4 5 6 7 8 9 10 11 12

Req/Plan  ██████
Design        ████
Backend          █████████
NLP/Chatbot       █████████
n8n Workflows        █████████
Frontend (web)           ███████
Testing                     ███████
Deployment                        ███████

```

---

# 🎯 **Top-Level Milestones Summary**

| Milestone | Description | Week |
| --- | --- | --- |
| **M1–M2** | Requirements + Architecture Approved | 1–2 |
| **M3** | All designs approved | 3 |
| **M4–M5** | Backend + DB ready | 4–6 |
| **M6–M7** | Chatbot + NLP functional | 6–7 |
| **M8–M9** | n8n workflows complete | 7–8 |
| **M10** | Chat UI integrated | 9 |
| **M11–M12** | QA + UAT passed | 10 |
| **M13–M14** | Deployment + Sign-Off | 11–12 |