---
name: task:decompose
version: "1.0.0"
description: 将规格分解为实施任务。Decomposes a specification into actionable implementation tasks using AI analysis.
tags: [task, decomposition, planning, ai]
allowed-tools:
  - Read
  - Write
  - Task
  - TodoWrite
  - Bash
argument-hint: <spec-id> [options]
arguments:
  - name: spec-id
    type: string
    required: true
    description: Specification ID to decompose
    pattern: "^[A-Z]+-[0-9]+$"
  - name: options
    type: string
    required: false
    description: Optional flags: --assignee, --estimate, --dependencies, --save
    pattern: "^(--assignee [a-zA-Z0-9_-]+|--estimate|--dependencies|--save)*$"
examples:
  - command: "/task decompose SPEC-001"
    description: 分解SPEC-001为任务 | Decompose SPEC-001 into tasks
  - command: "/task decompose SPEC-001 --assignee john --estimate"
    description: 分解并分配给john，包含估算 | Decompose, assign to john with estimates
  - command: "/task decompose SPEC-001 --save --dependencies"
    description: 分解并保存任务，包含依赖关系 | Decompose and save tasks with dependencies
categories: [task, planning, development]
author: "Deeka Wong"
license: MIT
---

# Decompose Tasks | 分解任务

Decompose specification: **$ARGUMENTS**
分解规格：**$ARGUMENTS**

## Current State | 当前状态

- Working directory: !`pwd`
- Specification exists: !`find specs -name "*${ARGUMENTS}*"`
- Task-analyst agent available: !`find plugins/spec/agents/task-analyst.md | head -1`

## Task | 任务

Decompose specification using task-analyst agent:
使用task-analyst代理分解规格：

### 1. Parse Arguments | 解析参数

- **spec-id**: `$ARGUMENTS[0]` - Specification to decompose
- **options**: Parse flags:
  - `--assignee name`: Auto-assign tasks to person
  - `--estimate`: Include time estimates
  - `--dependencies`: Include task dependencies
  - `--save`: Save tasks to file system

### 2. Load Specification | 加载规格

```bash
# Find specification file
SPEC_FILE=$(find specs -name "*${ARGUMENTS}*.md" -type f | head -1)

# Extract specification content
cat "$SPEC_FILE"
```

### 3. Use Task-Analyst Agent | 使用任务分析代理

Invoke task-analyst subagent:
调用任务分析子代理：

```
Use the task-analyst agent to decompose the specification "${ARGUMENTS}".

The specification content is:
${SPEC_CONTENT}

Please analyze and decompose this specification into actionable tasks.
Consider:
- Task granularity (1-3 days per task)
- Dependencies between tasks
- Required skills for each task
- Effort estimates if --estimate flag is used
- Assignee if --assignee is specified
```

### 4. Process Task Output | 处理任务输出

Parse agent output and:
解析代理输出并：

- **Extract tasks** from the response
- **Validate task format**
- **Apply options** (assignee, estimates, dependencies)
- **Create TODO list** using TodoWrite tool

### 5. Save Tasks (if --save) | 保存任务

If `--save` flag provided:
如果提供了 `--save` 标志：

```bash
# Create tasks directory
mkdir -p tasks/${ARGUMENTS}

# Save each task as separate file
for task in "${TASKS[@]}"; do
    TASK_ID=$(echo "$task" | jq -r '.id')
    echo "$task" > "tasks/${ARGUMENTS}/${TASK_ID}.task.md"
done
```

## Output Format | 输出格式

### Task Summary | 任务摘要

```
┌─────────────────────────────────────────────────────────────┐
│ Task Decomposition: SPEC-001                               │
├─────────────────────┬───────────────────────────────────────┤
│ Specification       │ User Authentication System            │
│ Total Tasks         │ 12                                    │
│ Total Effort        │ 34 story points                       │
│ Estimated Duration  │ 3 weeks                               │
│ Dependencies        │ 8 identified                          │
└─────────────────────┴───────────────────────────────────────┘
```

### Task List | 任务列表

```
## Phase 1: Foundation (Week 1)

### TASK-001: Database Schema Design
- **Effort**: 5 story points
- **Duration**: 2-3 days
- **Assignee**: john
- **Dependencies**: None
- **Skills**: Database design, SQL

### TASK-002: Authentication API
- **Effort**: 8 story points
- **Duration**: 3-4 days
- **Assignee**: john
- **Dependencies**: TASK-001
- **Skills**: Node.js, JWT, REST API

## Phase 2: Frontend (Week 2)

### TASK-003: Login Component
- **Effort**: 3 story points
- **Duration**: 1-2 days
- **Assignee**: sarah
- **Dependencies**: TASK-002
- **Skills**: React, Forms, UX
```

### Dependency Graph | 依赖图

```
TASK-001 (DB Schema)
    ↓
TASK-002 (Auth API)
    ↓
┌─────────────┬─────────────┐
│ TASK-003    │ TASK-004    │
│ (Login UI)  │ (User Mgmt) │
└─────────────┴─────────────┘
```

## Task Categories | 任务类别

### Design Tasks | 设计任务

- UI/UX mockups
- Architecture diagrams
- Database schema
- API specifications

### Implementation Tasks | 实施任务

- Backend development
- Frontend development
- Database implementation
- Integration development

### Testing Tasks | 测试任务

- Unit tests
- Integration tests
- End-to-end tests
- Performance tests

### Documentation Tasks | 文档任务

- API documentation
- User guides
- Technical documentation
- Deployment guides

### Deployment Tasks | 部署任务

- Environment setup
- CI/CD pipeline
- Migration scripts
- Monitoring setup

## Decomposition Strategy | 分解策略

### Granularity Rules | 粒度规则

- **Small tasks**: 1 day or less
- **Medium tasks**: 2-3 days
- **Large tasks**: Break down further
- **Epic tasks**: Multiple levels of decomposition

### Best Practices | 最佳实践

1. **Start with user stories**: What value does this deliver?
2. **Identify components**: What modules or features needed?
3. **Break down vertically**: Include UI, backend, and tests
4. **Consider dependencies**: What must be done first?
5. **Include testing**: Every feature needs tests
6. **Add documentation**: Document as you go

## Advanced Features | 高级功能

### Custom Templates | 自定义模板

Use decomposition templates:
使用分解模板：

```bash
/task decompose SPEC-001 --template "microservice"
```

Available templates:
可用模板：

- **microservice**: Microservice architecture pattern
- **monolith**: Monolithic application pattern
- **mobile**: Mobile app development
- **api**: API-first development

### Risk Assessment | 风险评估

Include risk analysis:
包含风险分析：

```
Risk Assessment:
- High Risk: TASK-007 (Third-party integration)
- Medium Risk: TASK-011 (Performance optimization)
- Low Risk: TASK-003 (UI component)
```

### Resource Planning | 资源规划

Generate resource allocation plan:
生成资源分配计划：

```
Resource Requirements:
- Frontend Developer: 40% of effort
- Backend Developer: 50% of effort
- QA Engineer: 10% of effort
- DevOps Engineer: 5% of effort (overhead)
```

## Implementation Steps | 实施步骤

1. **Parse command arguments** and options
2. **Locate specification file** by ID
3. **Read specification content**
4. **Invoke task-analyst agent** with specification
5. **Process and validate** task output
6. **Apply command options** (assignee, estimates, etc.)
7. **Create TODO list** with all tasks
8. **Save task files** if --save specified
9. **Generate summary report** with metrics
10. **Display dependency graph** if requested

## Error Handling | 错误处理

- **Specification not found**: Error and suggest similar IDs
- **Decomposition fails**: Try with simpler approach
- **Invalid task format**: Show format requirements
- **Save fails**: Check permissions and disk space
- **Agent unavailable**: Fall back to manual template

## Integration | 集成

### With Project Tools | 与项目工具集成

- **Jira**: Export tasks to Jira format
- **GitHub**: Create GitHub issues
- **Asana**: Import to Asana project
- **Trello**: Create Trello cards

### Continuous Updates | 持续更新

Track decomposition quality:
跟踪分解质量：

```bash
# Monitor task completion vs estimates
/task track SPEC-001 --compare-estimates

# Adjust future decompositions based on history
/task decompose SPEC-002 --learn-from SPEC-001
```
