---
name: task:track
version: "1.0.0"
description: 跟踪任务进度并生成报告。Tracks task progress and generates progress reports.
tags: [task, tracking, progress, reporting]
allowed-tools:
  - Read
  - TodoWrite
  - Bash
argument-hint: [spec-id or assignee] [time-range]
arguments:
  - name: target
    type: string
    required: false
    description: Specification ID, assignee name, or leave blank for all tasks
    pattern: "^[A-Z]+-[0-9]+$|^[a-zA-Z][a-zA-Z0-9_-]*$|^$"
  - name: time-range
    type: string
    required: false
    description: Time range filter (last-day, last-week, last-month)
    pattern: "^(last-day|last-week|last-month)$|^$"
examples:
  - command: "/task track SPEC-001"
    description: 跟踪SPEC-001的任务进度 | Track tasks for SPEC-001
  - command: "/task track john last-week"
    description: 跟踪john上周的任务 | Track john's tasks from last week
  - command: "/task track last-month"
    description: 跟踪所有任务上个月的进度 | Track all tasks progress from last month
categories: [task, tracking, management]
author: "Deeka Wong"
license: MIT
---

# Track Progress | 跟踪进度

Track progress for: **$ARGUMENTS**
跟踪进度：**$ARGUMENTS**

## Current State | 当前状态

- Working directory: !`pwd`
- Task files found: !`find . -name "*.task.md" -type f 2>/dev/null | wc -l`
- Active TODO lists: !`find . -name "TODO.md" -type f 2>/dev/null | wc -l`

## Task | 任务

Generate progress reports:
生成进度报告：

### 1. Parse Arguments | 解析参数

- **target**: First argument
  - If starts with `SPEC-`: Track tasks for specification
  - If matches username: Track tasks for assignee
  - If empty: Track all tasks
- **time-range**: Second argument
  - `last-day`: Tasks from last 24 hours
  - `last-week`: Tasks from last 7 days
  - `last-month`: Tasks from last 30 days
  - If empty: All time

### 2. Collect Task Data | 收集任务数据

```bash
# Find all task files
find . -name "*.task.md" -type f | while read task_file; do
    # Extract metadata from each task
    # Filter by time range
    # Filter by target if specified
done

# Check TODO lists
find . -name "TODO.md" -type f | while read todo_file; do
    # Extract TODO items
    # Calculate completion percentage
done
```

### 3. Calculate Metrics | 计算指标

For each task set:
为每个任务集计算：

- **Completion rate**: Completed / Total tasks
- **Average task duration**: Time from assignment to completion
- **Velocity**: Tasks completed per time period
- **Bottlenecks**: Tasks taking longer than expected
- **Productivity**: Story points per person per week

### 4. Generate Reports | 生成报告

#### Progress Summary | 进度摘要

```
┌─────────────────────────────────────────────────────────────┐
│ Progress Report (Last Week)                                 │
├─────────────────────┬───────────────────────────────────────┤
│ Total Tasks         │ 45                                    │
│ Completed           │ 32 (71%)                              │
│ In Progress         │ 8                                     │
│ Blocked             │ 3                                     │
│ Not Started         │ 2                                     │
├─────────────────────┼───────────────────────────────────────┤
│ Team Velocity       │ 32 story points/week                  │
│ Average Duration    │ 2.3 days/task                         │
│ On-Time Completion  │ 78%                                   │
└─────────────────────┴───────────────────────────────────────┘
```

#### By Assignee | 按负责人

```
Team Performance:
┌─────────┬─────────┬─────────┬─────────────┬──────────────┐
│ Assignee│ Tasks   │ Completed│ Velocity    │ Efficiency   │
├─────────┼─────────┼─────────┼─────────────┼──────────────┤
│ john    │ 12      │ 10      │ 15 pts/wk   │ 95%          │
│ sarah   │ 8       │ 7       │ 12 pts/wk   │ 88%          │
│ mike    │ 15      │ 10      │ 18 pts/wk   │ 72%          │
│ lisa    │ 10      │ 5       │ 8 pts/wk    │ 85%          │
└─────────┴─────────┴─────────┴─────────────┴──────────────┘
```

#### By Specification | 按规格

```
Specification Progress:
┌─────────┬─────────────┬─────────┬─────────────┬──────────────┐
│ Spec ID │ Title       │ Tasks   │ Completed   │ % Complete   │
├─────────┼─────────────┼─────────┼─────────────┼──────────────┤
│ SPEC-001│ Auth System │ 12      │ 11          │ 92%          │
│ SPEC-002│ Dashboard   │ 8       │ 5           │ 63%          │
│ SPEC-003│ Reports     │ 15      │ 2           │ 13%          │
└─────────┴─────────────┴─────────┴─────────────┴──────────────┘
```

## Report Types | 报告类型

### Daily Standup | 每日站会

Quick overview for daily meetings:
每日会议的快速概览：

```
Daily Summary (john):
- Yesterday: Completed TASK-005, Started TASK-006
- Today: Continue TASK-006, Start TASK-007
- Blockers: Waiting for API design (SPEC-002)
```

### Weekly Report | 周报

Comprehensive weekly progress:
全面的周进度：

```
Weekly Highlights:
✅ Major achievements:
- Completed user authentication module
- Fixed 5 critical bugs
- Deployed to staging

⚠️ Issues:
- SPEC-003 delayed by design changes
- Team velocity down 15%

📊 Metrics:
- Sprint burndown: 80% complete
- Code quality: 92% test coverage
```

### Monthly Review | 月度回顾

Strategic monthly insights:
战略性月度洞察：

```
Monthly Trends:
📈 Improvements:
- Task completion time reduced by 20%
- Code review cycle time: -2 days
- Deploy frequency: +40%

📉 Challenges:
- Scope creep in 30% of specs
- QA bottleneck identified
- Technical debt increased

🎯 Recommendations:
- Implement stricter scope control
- Hire additional QA resource
- Plan tech debt sprints
```

## Visual Reports | 可视化报告

### Burndown Chart | 燃尽图

```
Sprint Burndown (2-week sprint):
Day ┤ Tasks Remaining
    ┤
50 ┤█████████████████
45 ┤█████████████████
40 ┤█████████████████
35 ┤█████████████████
30 ┤█████████████████
25 ┤█████████████████
20 ┤███████████████░
15 ┤████████████░░░░
10 ┤████████░░░░░░░
 5 ┤████░░░░░░░░░░░
 0 ┤░░░░░░░░░░░░░░░░
    └─────────────────
      M T W T F M T W T F
```

### Velocity Chart | 速度图

```
Team Velocity (Last 8 sprints):
Sprint ┤ Story Points
      ┤
30 ┤          ████
25 ┤      ████████
20 ┤  ████████████
15 ┤████████████████
10 ┤████████████████
 5 ┤████████████████
 0 └─────────────────
      S1 S2 S3 S4 S5 S6 S7 S8

Average: 22.5 pts/sprint
```

## Advanced Analytics | 高级分析

### Predictive Analysis | 预测分析

Based on current velocity:
基于当前速度：

```
Completion Predictions:
- SPEC-001: 3 days remaining (on track)
- SPEC-002: 5 days overdue (behind)
- SPEC-003: 2 weeks ahead (early)

Risk Assessment:
- High Risk: SPEC-002 (blocked by external dependency)
- Medium Risk: SPEC-003 (complexity underestimated)
- Low Risk: SPEC-001 (progressing well)
```

### Resource Utilization | 资源利用率

Team workload analysis:
团队工作负载分析：

```
Resource Allocation:
┌─────────┬─────────┬─────────┬─────────────┐
│ Resource│ Capacity │ Allocated│ Utilization │
├─────────┼─────────┼─────────┼─────────────┤
│ Dev Team│ 100 hrs │ 85 hrs  │ 85%          │
│ QA Team │ 60 hrs  │ 75 hrs  │ 125% (over)  │
│ Design  │ 40 hrs  │ 30 hrs  │ 75%          │
└─────────┴─────────┴─────────┴─────────────┘

Recommendation: Consider reassigning tasks from QA to Dev
```

## Implementation Steps | 实施步骤

1. **Parse command arguments** and filters
2. **Scan for task files** and TODO lists
3. **Extract task metadata** (status, assignee, dates)
4. **Apply time filters** if specified
5. **Calculate metrics** and KPIs
6. **Generate appropriate report** based on time range
7. **Create visualizations** if requested
8. **Provide recommendations** based on data
9. **Export report** if needed

## Export Options | 导出选项

### JSON Export | JSON导出

```bash
/task track SPEC-001 --format json > report.json
```

### CSV Export | CSV导出

```bash
/task track --format csv > tasks.csv
```

### PDF Report | PDF报告

```bash
/task track --report-type monthly --format pdf > monthly-report.pdf
```

## Error Handling | 错误处理

- **No tasks found**: Check if tracking is properly configured
- **Invalid time range**: Show valid options
- **Parse errors**: Skip malformed task files with warning
- **Permission issues**: Report file access problems
