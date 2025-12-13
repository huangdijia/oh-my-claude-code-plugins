---
name: task:assign
version: "1.0.0"
description: 分配或重新分配任务给团队成员。Assigns tasks to team members or reassigns existing tasks.
tags: [task, assignment, team, management]
allowed-tools:
  - Read
  - Write
  - Edit
  - TodoWrite
argument-hint: <task-id or spec-id> <assignee>
arguments:
  - name: target
    type: string
    required: true
    description: Task ID (TASK-XXX) or specification ID (SPEC-XXX) to assign
    pattern: "^(TASK|SPEC)-[0-9]+$"
  - name: assignee
    type: string
    required: true
    description: Name or ID of the assignee
    pattern: "^[a-zA-Z][a-zA-Z0-9_-]*$"
examples:
  - command: "/task assign TASK-001 john"
    description: 将TASK-001分配给john | Assign TASK-001 to john
  - command: "/task assign SPEC-001 sarah"
    description: 将SPEC-001的所有未分配任务分配给sarah | Assign all unassigned tasks from SPEC-001 to sarah
  - command: "/task assign TASK-005 mike_smith"
    description: 将TASK-005重新分配给mike_smith | Reassign TASK-005 to mike_smith
categories: [task, management, workflow]
author: "Deeka Wong"
license: MIT
---

# Assign Tasks | 分配任务

Assign task: **$ARGUMENTS**
分配任务：**$ARGUMENTS**

## Current State | 当前状态

- Working directory: !`pwd`
- Task files found: !`find . -name "*.task.md" -type f 2>/dev/null | wc -l`
- Active TODO lists: !`find . -name "TODO.md" -type f 2>/dev/null | wc -l`

## Task | 任务

Process task assignment:
处理任务分配：

### 1. Parse Arguments | 解析参数

- **target**: `$ARGUMENTS[0]` - Task ID or Specification ID
  - If starts with `TASK-`: Assign specific task
  - If starts with `SPEC-`: Assign all unassigned tasks from spec
- **assignee**: `$ARGUMENTS[1]` - Name or ID of assignee

### 2. Validate Assignment | 验证分配

```bash
# Check if target exists
if [[ $ARGUMENTS =~ ^TASK- ]]; then
    find . -name "*${ARGUMENTS}*.task.md" -type f
elif [[ $ARGUMENTS =~ ^SPEC- ]]; then
    find specs -name "*${ARGUMENTS}*.md" -type f
fi
```

### 3. Check Assignee Availability | 检查分配人可用性

- Verify assignee exists in team
- Check current workload
- Validate assignee is not overloaded

### 4. Perform Assignment | 执行分配

#### For Single Task | 单个任务

1. **Load task file** with task ID
2. **Update metadata**:

   ```yaml
   assignee: [ASSIGNEE]
   assigned_date: [CURRENT_DATE]
   status: in-progress (if was unassigned)
   ```

3. **Update TODO list** if task is tracked there
4. **Log assignment** in assignment history

#### For Specification | 规格文档

1. **Find all tasks** related to specification
2. **Filter unassigned tasks** (assignee: null or empty)
3. **Batch update** all found tasks
4. **Update specification status** if needed

### 5. Assignment Rules | 分配规则

- **Workload balance**: Don't overload assignees
- **Skill matching**: Assign based on task requirements
- **Priority handling**: High-priority tasks first
- **Conflict resolution**: Handle if already assigned

## Output Format | 输出格式

### Single Task Assignment | 单个任务分配

```
┌─────────────────────────────────────────────────────────────┐
│ Task Assignment Complete                                     │
├─────────────────────┬───────────────────────────────────────┤
│ Task ID             │ TASK-001                              │
│ Title               │ Implement user authentication API     │
│ Previous Assignee   │ Unassigned                            │
│ New Assignee        │ john                                  │
│ Assigned At         │ 2025-01-25 10:30                      │
│ Status              │ in-progress                           │
└─────────────────────┴───────────────────────────────────────┘

Notification sent to: john@example.com
```

### Batch Assignment | 批量分配

```
┌─────────────────────────────────────────────────────────────┐
│ Batch Assignment Complete                                   │
├─────────────────────┬───────────────────────────────────────┤
│ Specification       │ SPEC-001                              │
│ Assignee            │ sarah                                 │
│ Tasks Assigned      │ 5                                     │
│ Total Effort        │ 13 story points                       │
└─────────────────────┴───────────────────────────────────────┘

Assigned Tasks:
- TASK-003: Design database schema (3 pts)
- TASK-004: Implement auth middleware (5 pts)
- TASK-005: Create login page (2 pts)
- TASK-006: Write unit tests (2 pts)
- TASK-007: Update documentation (1 pt)
```

## Team Management | 团队管理

### Workload Tracking | 工作负载跟踪

Before assignment, check:
分配前检查：

```bash
# Current assignments by person
grep -r "assignee: john" . --include="*.task.md" | wc -l

# Total effort by assignee
grep -A 5 "assignee: john" . --include="*.task.md" | grep effort
```

### Skill Matrix | 技能矩阵

Consider assignee skills:
考虑分配人技能：

- **Frontend**: React, Vue, CSS, UX
- **Backend**: Node.js, Python, databases
- **DevOps**: Docker, AWS, CI/CD
- **Testing**: Unit, E2E, automation

## Assignment History | 分配历史

Track all assignments:
跟踪所有分配：

```markdown
# Assignment History
| Date       | Task ID | Assignee | Action      | Reason          |
|------------|---------|----------|-------------|-----------------|
| 2025-01-25 | TASK-001| john     | assigned    | Initial         |
| 2025-01-26 | TASK-001| john     | in-progress | Started work    |
| 2025-01-28 | TASK-001| mike     | reassigned  | john overloaded |
```

## Notification System | 通知系统

### Email Notification | 邮件通知

Send notification to assignee:
向分配人发送通知：

```bash
# Mock email command
send-email \
  --to="${ASSIGNEE}@company.com" \
  --subject="New Task Assignment: ${TASK_ID}" \
  --body="You have been assigned ${TASK_ID}: ${TASK_TITLE}"
```

### Slack Notification | Slack通知

Post to Slack channel:
发送到Slack频道：

```bash
# Mock Slack command
slack-post \
  --channel="#assignments" \
  --message="📋 ${ASSIGNEE} has been assigned ${TASK_ID}: ${TASK_TITLE}"
```

## Implementation Steps | 实施步骤

1. **Parse and validate** arguments
2. **Determine assignment type** (single vs batch)
3. **Check assignee availability** and workload
4. **Locate target tasks** or specification
5. **Update task files** with new assignee
6. **Update TODO lists** if applicable
7. **Log assignment** in history
8. **Send notifications** if configured
9. **Display confirmation** with summary

## Error Handling | 错误处理

- **Task not found**: Show error and suggest similar IDs
- **Already assigned**: Ask if reassigning
- **Assignee not found**: Suggest valid assignees
- **Permission denied**: Check file permissions
- **Invalid format**: Show correct format examples

## Advanced Options | 高级选项

### Force Reassign | 强制重新分配

Add `--force` flag to override existing assignments:
添加 `--force` 标志覆盖现有分配：

```bash
/task assign TASK-001 sarah --force
```

### Bulk Assignment | 批量分配

Assign multiple tasks:
分配多个任务：

```bash
/task assign TASK-001,TASK-002,TASK-003 john
```

### Assignment Templates | 分配模板

Use predefined assignment rules:
使用预定义分配规则：

```bash
/task assign SPEC-001 --template "frontend-team"
```
