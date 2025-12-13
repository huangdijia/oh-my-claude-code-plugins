---
name: spec:status
version: "1.0.0"
description: 显示规格的详细状态信息。Shows detailed status and progress information for a specification.
tags: [spec, status, tracking, progress]
allowed-tools:
  - Read
  - Glob
  - Bash
  - TodoWrite
argument-hint: [spec-id]
arguments:
  - name: spec-id
    type: string
    required: false
    description: Specification ID to check status (shows overall project status if not provided)
    pattern: "^[A-Z]+-[0-9]+$|^$"
examples:
  - command: "/spec status SPEC-001"
    description: 显示SPEC-001的详细状态 | Show detailed status for SPEC-001
  - command: "/spec status"
    description: 显示所有规格的项目概览 | Show overall project overview of all specs
categories: [documentation, tracking, management]
author: "Deeka Wong"
license: MIT
---

# Specification Status | 规格状态

Check specification status: **$ARGUMENTS**
检查规格状态：**$ARGUMENTS**

## Current State | 当前状态

- Working directory: !`pwd`
- Specs directory exists: !`test -d specs && echo "✅ Yes" || echo "❌ No"`
- Active specifications: !`find specs -name "*.md" -type f 2>/dev/null | wc -l`

## Task | 任务

Display detailed status information:
显示详细状态信息：

### 1. Parse Arguments | 解析参数

- **With spec-id**: Show status for specific specification
- **Without spec-id**: Show overall project status summary

### 2. Load Specification | 加载规格

If spec-id provided:
如果提供了spec-id：

```bash
# Find specification file
find specs -name "*${ARGUMENTS}*" -type f | head -1
```

Extract frontmatter data:
提取前置数据：

- spec_id
- title
- spec_type
- status
- priority
- assignee
- created_date
- updated_date
- due_date
- tags

### 3. Calculate Progress Metrics | 计算进度指标

For the specification:
为规格计算：

- **Completion percentage**: Based on task completion
- **Tasks completed/total**: From TODO items or task files
- **Days since creation**: From created_date to now
- **Days since last update**: From updated_date to now
- **Days until due**: From now to due_date

### 4. Find Related Tasks | 查找相关任务

```bash
# Find related task files
find . -name "*${ARGUMENTS}*" -name "*.task.md" -type f
find . -name "tasks" -type d -exec grep -l "${ARGUMENTS}" {} \;
```

### 5. Check Dependencies | 检查依赖关系

- **Blockers**: Tasks or specs blocking this one
- **Dependencies**: This spec's dependencies
- **Related specs**: Specifications with similar tags or assignee

## Output Format | 输出格式

### Individual Specification Status | 单个规格状态

```
┌─────────────────────────────────────────────────────────────┐
│ SPEC-001 | User Authentication System                       │
├─────────────────────┬───────────────────────────────────────┤
│ Type                │ requirements                          │
│ Status              │ draft                                 │
│ Priority            │ high                                  │
│ Assignee            │ john                                  │
│ Created             │ 2025-01-15 (10 days ago)             │
│ Last Updated        │ 2025-01-20 (5 days ago)              │
│ Due Date            │ 2025-02-15 (10 days remaining)       │
├─────────────────────┼───────────────────────────────────────┤
│ Progress            │ ████████░░ 80%                       │
│ Tasks               │ 8/10 completed                        │
│ Blockers            │ API design (SPEC-002)                 │
└─────────────────────┴───────────────────────────────────────┘
```

### Project Overview | 项目概览

```markdown
┌─────────────────────────────────────────────────────────────┐
│ Project Status Overview                                     │
├─────────────┬──────────┬─────────┬─────────────┬───────────┤
│ Total Specs │ Draft    │ Review  │ Approved    │ In-Progress│
├─────────────┼──────────┼─────────┼─────────────┼───────────┤
│ 12          │ 3        │ 2       │ 4           │ 3         │
├─────────────┼──────────┼─────────┼─────────────┼───────────┤
│ This Week   │ +1       │ +2      │ +1          │ -1        │
└─────────────┴──────────┴─────────┴─────────────┴───────────┘

Priority Breakdown:
- Critical: 2 specifications
- High: 5 specifications
- Medium: 4 specifications
- Low: 1 specification
```

## Status Details | 状态详情

### Status Values | 状态值

- **draft**: Initial work in progress
- **review**: Ready for review
- **approved**: Approved for implementation
- **in-progress**: Currently being implemented
- **testing**: Under testing
- **completed**: Implementation complete
- **blocked**: Blocked by dependencies
- **archived**: No longer active

### Priority Levels | 优先级

- **critical**: Must be done immediately
- **high**: Important, should be done soon
- **medium**: Normal priority
- **low**: Can be deferred

## Implementation Steps | 实施步骤

1. **Validate spec-id** if provided
2. **Find specification file** in specs directory
3. **Parse frontmatter** to extract metadata
4. **Calculate dates and durations**
5. **Search for related tasks** and their status
6. **Check dependencies** and blockers
7. **Generate progress metrics**
8. **Format and display** status report

## Advanced Features | 高级功能

### Status History | 状态历史

Track status changes over time:
跟踪状态变化历史：

```bash
# Git commit history for status changes
git log --follow --grep="${ARGUMENTS}" --oneline
```

### Burndown Chart | 燃尽图

Generate simple burndown chart:
生成简单燃尽图：

```
Days ┤
    │     ╭─╮
 10 │ ╭─╮╭─╯ ╰╮
  5 │╭─╯│╰─╮  ╰╮
  0 │╰──╯╰──╯  ╰─────
    └───────────────────
      Jan Jan Jan Jan
      15  18  21  24
```

### Team Workload | 团队工作负载

Show work distribution by assignee:
显示按负责人的工作分布：

```
Team Workload:
┌─────────┬─────────┬──────────┬─────────────┐
│ Assignee│ Active  │ Overdue  │ Total Points │
├─────────┼─────────┼──────────┼─────────────┤
│ john    │ 3       │ 1        │ 21          │
│ sarah   │ 2       │ 0        │ 15          │
│ mike    │ 4       │ 2        │ 28          │
└─────────┴─────────┴──────────┴─────────────┘
```

## Error Handling | 错误处理

- **Spec not found**: Display error and suggest similar IDs
- **Invalid frontmatter**: Show warning and continue with partial data
- **No tasks found**: Display message about task decomposition
- **Permission errors**: Check file permissions and report
