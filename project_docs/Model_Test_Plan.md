# 🧪 Model Performance Test Plan
**Objective:** Determine if a small SLM (Small Language Model) like **Qwen-2.5-3B** can replace Gemini 1.5 Flash for the HR Chatbot.

## 1. The Setup
*   **Model:** `qwen2.5:3b` (via Ollama/LM Studio)
*   **System Prompt:** (Must be strict to help the small model focus).

### 📋 System Prompt Template
```text
You are an HR Assistant. Extract data from the user's text into JSON format.
Current Date: 2026-01-04 (Sunday)

Rules:
1. Intent must be: 'leave_request', 'check_balance', 'unknown'.
2. Output JSON ONLY. No markdown, no conversation.
3. Calculate dates relative to Current Date.

JSON Structure:
{
  "intent": "string",
  "entities": {
    "type": "sick | vacation | null",
    "start_date": "YYYY-MM-DD",
    "end_date": "YYYY-MM-DD",
    "reason": "string | null"
  }
}
```

---

## 2. The Test Suite (5 Scenarios)

### 🟢 Test Case 1: Simple Thai Request
**Input:** "ขอลาป่วยพรุ่งนี้ครับ ปวดหัว"
*   **Expected Logic:** "Tomorrow" = 2026-01-05.
*   **Pass Criteria:**
    ```json
    { "intent": "leave_request", "entities": { "type": "sick", "start_date": "2026-01-05", "end_date": "2026-01-05", "reason": "ปวดหัว" } }
    ```

### 🟡 Test Case 2: Date Range & English Mixing
**Input:** "I want to take vacation leave from next Monday to Wednesday."
*   **Expected Logic:** "Next Monday" (from Jan 4) = Jan 12. "Wednesday" = Jan 14.
*   **Pass Criteria:** `start_date`="2026-01-12", `end_date`="2026-01-14".

### 🟠 Test Case 3: Balance Check (No Dates)
**Input:** "เหลือวันลาพักร้อนกี่วัน?"
*   **Pass Criteria:**
    ```json
    { "intent": "check_balance", "entities": { "type": "vacation", "start_date": null, "end_date": null, "reason": null } }
    ```

### 🔴 Test Case 4: Complex/Slang (Stress Test)
**Input:** "ไม่ไหวแล้ว ขอลากิจ 13-15 เดือนหน้า กลับต่างจังหวัด"
*   **Expected Logic:** "Next Month" = February 2026. Dates = 2026-02-13 to 2026-02-15.
*   **Pass Criteria:** Correct specific dates in February.

### ⚪ Test Case 5: Irrelevant (Chit-chat)
**Input:** "สวัสดีครับ กินข้าวหรือยัง"
*   **Pass Criteria:** `intent`: "unknown".

---

## 3. Evaluation Sheet

| Test Case | Success? (Y/N) | Error Notes (e.g., Wrong Date, Bad JSON) |
| :--- | :--- | :--- |
| 1. Simple Thai | [ ] | |
| 2. Date Range | [ ] | |
| 3. Balance Check | [ ] | |
| 4. Complex/Slang| [ ] | |
| 5. Irrelevant | [ ] | |

**Passing Score:** 4/5 (80%) is required for a usable prototype.
