---
name: workflow:sync
version: "1.0.0"
description: 同步规格文档与实施状态。Synchronizes specification documents with current implementation status.
tags: [workflow, sync, status, synchronization]
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
argument-hint: [spec-id]
arguments:
  - name: spec-id
    type: string
    required: false
    description: Specification ID to sync (syncs all if not provided)
    pattern: "^[A-Z]+-[0-9]+$|^$"
examples:
  - command: "/workflow sync SPEC-001"
    description: 同步SPEC-001的状态 | Sync SPEC-001 status
  - command: "/workflow sync"
    description: 同步所有规格文档 | Sync all specifications
categories: [workflow, synchronization, management]
author: "Deeka Wong"
license: MIT
---

# Sync Workflow | 同步工作流

Sync specifications: **$ARGUMENTS**
同步规格：**$ARGUMENTS**

## Current State | 当前状态

- Working directory: !`pwd`
- Specifications to sync: !`test -n "$ARGUMENTS" && echo "1" || find specs -name "*.md" -type f 2>/dev/null | wc -l`
- Git status: !`git status --porcelain 2>/dev/null | head -5 || echo "Not a git repository"`

## Task | 任务

Synchronize specifications with implementation:
同步规格与实施：

### 1. Parse Arguments | 解析参数

- **spec-id**: If provided, sync specific specification
- **no argument**: Sync all specifications in project

### 2. Scan for Changes | 扫描变更

Check various sources for status updates:
检查各种来源的状态更新：

```bash
# Git commits since last sync
git log --since="$(git config --get sync.lastsync 2>/dev/null || echo '1970-01-01')" --oneline

# Task files status
find . -name "*.task.md" -type f -exec grep -l "status.*completed\|status.*in-progress" {} \;

# Implementation artifacts
find src/ -type f -newer specs/.lastsync 2>/dev/null
```

### 3. Update Implementation Status | 更新实施状态

For each specification:
为每个规格：

#### Check Task Completion | 检查任务完成

```bash
# Count tasks for specification
TASK_TOTAL=$(find tasks -name "*${SPEC_ID}*.task.md" -type f | wc -l)
TASK_DONE=$(grep -l "status.*completed" tasks/*${SPEC_ID}*.task.md 2>/dev/null | wc -l)
TASK_PROGRESS=$((TASK_DONE * 100 / TASK_TOTAL))
```

#### Update Status Fields | 更新状态字段

- **status**: Update based on task progress
  - 0%: `draft`
  - 1-49%: `in-progress`
  - 50-99%: `testing`
  - 100%: `completed`
- **updated_date**: Current timestamp
- **progress**: Percentage complete
- **implementation_notes**: Recent changes summary

### 4. Check for Stale Specifications | 检查过期文档

Identify specifications that might be outdated:
识别可能过时的规格：

```markdown
Stale Specification Indicators:
- Last updated > 30 days ago
- No tasks created
- No implementation artifacts
- Status unchanged for long period
```

### 5. Update Dependencies | 更新依赖关系

Check and update specification dependencies:
检查并更新规格依赖：

```bash
# Find circular dependencies
grep -r "depends.*${SPEC_ID}" specs/ | while read dep; do
    # Validate dependency still exists
    # Update dependency status if needed
done
```

## Sync Report | 同步报告

### Summary Overview | 摘要概览

```
┌─────────────────────────────────────────────────────────────┐
│ Synchronization Report (2025-01-25 14:30)                     │
├─────────────────────┬───────────────────────────────────────┤
│ Specifications Scanned│ 12                                    │
│ Updated             │ 5                                     │
│ No Changes          │ 6                                     │
│ Issues Found        │ 1                                     │
├─────────────────────┼───────────────────────────────────────┤
│ Last Sync           │ 2025-01-24 09:00                       │
│ Duration            │ 2.3 seconds                           │
└─────────────────────┴───────────────────────────────────────┘
```

### Detailed Changes | 详细变更

```
Updated Specifications:

SPEC-001: User Authentication
- Status: in-progress → testing (75% complete)
- Tasks: 8/10 completed
- Last updated: 2025-01-25 14:28
- Changes: API implementation complete, testing in progress

SPEC-003: Reporting Module
- Status: draft → in-progress (25% complete)
- Tasks: 2/8 completed
- Last updated: 2025-01-25 14:29
- Changes: Database schema implemented

Issues Identified:
- SPEC-005: No tasks found, needs decomposition
- Recommendation: Run /task decompose SPEC-005
```

## Automated Sync Actions | 自动同步操作

### Status Updates | 状态更新

Automatic status transitions:
自动状态转换：

```yaml
# Based on task completion
if tasks_completed == total_tasks:
    status = "completed"
elif tasks_completed > 0:
    if progress >= 50:
        status = "testing"
    else:
        status = "in-progress"
```

### Progress Calculation | 进度计算

Weighted progress by task type:
按任务类型加权进度：

```python
def calculate_progress(tasks):
    weights = {
        "design": 0.15,
        "implementation": 0.60,
        "testing": 0.20,
        "documentation": 0.05
    }

    total = 0
    for task in tasks:
        total += task.completion * weights[task.type]

    return min(total, 100)
```

### Dependency Updates | 依赖更新

Cascade dependency status:
级联依赖状态：

```bash
# If dependency completed, update dependents
for dep in $(find deps -name "${SPEC_ID}*"); do
    update_dependent_status $dep
done
```

## Implementation Details | 实施细节

### Detection Methods | 检测方法

1. **File timestamps**: Compare modification times
2. **Git history**: Track commits since last sync
3. **Task status**: Monitor task completion
4. **Code artifacts**: Check for implementation files
5. **Test results**: Verify test coverage

### Sync Triggers | 同步触发器

Automatic sync can be triggered by:
自动同步可由以下触发：

- Git push/commit
- Task status change
- Scheduled (daily/weekly)
- Manual command
- CI/CD pipeline events

### Conflict Resolution | 冲突解决

Handle conflicting changes:
处理冲突变更：

```markdown
Conflict Resolution Priority:
1. Manual user input (highest)
2. Task completion status
3. Git commit history
4. File timestamps (lowest)
```

## Advanced Features | 高级功能

### Selective Sync | 选择性同步

Sync specific aspects only:
仅同步特定方面：

```bash
# Sync only status
/workflow sync SPEC-001 --status-only

# Sync only dependencies
/workflow sync --dependencies-only

# Sync specific fields
/workflow sync SPEC-001 --fields status,progress
```

### Batch Operations | 批量操作

Process multiple specifications:
处理多个规格：

```bash
# Sync all draft specifications
/workflow sync --filter status:draft

# Sync by assignee
/workflow sync --assignee john

# Sync by priority
/workflow sync --priority high,critical
```

### Validation Mode | 验证模式

Check without applying changes:
检查而不应用更改：

```bash
# Dry run sync
/workflow sync --dry-run

# Show what would change
/workflow sync SPEC-001 --preview
```

## Integration | 集成

### Git Integration | Git集成

Automatically commit changes:
自动提交更改：

```bash
git add specs/
git commit -m "Sync specifications [skip ci]"
git tag -a "sync-$(date +%Y%m%d-%H%M)" -m "Sync point"
```

### CI/CD Pipeline | CI/CD流水线

Add to deployment pipeline:
添加到部署流水线：

```yaml
# .github/workflows/sync.yml
- name: Sync Specifications
  run: |
    /workflow sync
    git push --follow-tags
```

### Notification System | 通知系统

Alert on important changes:
重要变更提醒：

```bash
# Notify on specification completion
if [[ $status == "completed" ]]; then
    notify-team "SPEC-${SPEC_ID} implementation complete!"
fi
```

## Implementation Steps | 实施步骤

1. **Determine sync scope** (all or specific)
2. **Load all specifications** from specs directory
3. **Gather implementation data** from various sources
4. **Calculate new status** for each specification
5. **Detect conflicts** and resolve according to rules
6. **Update specification files** with new data
7. **Validate updates** ensure consistency
8. **Generate sync report** with changes
9. **Commit changes** if in git repository
10. **Send notifications** for important updates

## Error Handling | 错误处理

- **Specification not found**: Skip with warning
- **Parse errors**: Report and continue
- **Conflicting changes**: Use resolution priority
- **Permission denied**: Report and skip
- **Git conflicts**: Flag for manual resolution

## Maintenance | 维护

### Regular Tasks | 定期任务

- Daily: Incremental sync of active specs
- Weekly: Full sync and report generation
- Monthly: Cleanup old sync points
- Quarterly: Review and optimize sync rules

### Performance Optimization | 性能优化

- Cache specification data
- Parallel sync processing
- Incremental sync when possible
- Compress historical sync data