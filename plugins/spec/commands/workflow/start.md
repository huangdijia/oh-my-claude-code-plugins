---
name: workflow:start
version: "1.0.0"
description: 启动新的规格驱动开发工作流。Initiates a complete spec-driven development workflow from idea to implementation.
tags: [workflow, spec-driven, automation, process]
allowed-tools:
  - Task
  - Write
  - Read
  - TodoWrite
argument-hint: <workflow-type> <title>
arguments:
  - name: workflow-type
    type: string
    required: true
    description: Type of workflow to start
    pattern: "^(feature|bug-fix|improvement|research)$"
  - name: title
    type: string
    required: true
    description: Brief title for the workflow (use quotes if contains spaces)
examples:
  - command: "/workflow start feature \"User Dashboard\""
    description: 启动功能开发工作流 | Start feature development workflow
  - command: "/workflow start bug-fix \"Memory Leak in Reports\""
    description: 启动Bug修复工作流 | Start bug fix workflow
  - command: "/workflow start improvement \"Performance Optimization\""
    description: 启动改进工作流 | Start improvement workflow
  - command: "/workflow start research \"AI Integration Options\""
    description: 启动研究工作流 | Start research workflow
categories: [workflow, automation, development]
author: "Deeka Wong"
license: MIT
---

# Start Workflow | 启动工作流

Start new workflow: **$ARGUMENTS**
启动新工作流：**$ARGUMENTS**

## Current State | 当前状态

- Working directory: !`pwd`
- Specs directory: !`test -d specs && echo "✅ Ready" || echo "❌ Need setup"`
- Active workflows: !`find workflows -name "*.md" -type f 2>/dev/null | wc -l`

## Task | 任务

Initialize spec-driven workflow:
初始化规格驱动工作流：

### 1. Parse Arguments | 解析参数

- **workflow-type**: `$ARGUMENTS[0]` - Type of workflow
  - `feature`: New feature development
  - `bug-fix`: Bug resolution process
  - `improvement`: Enhancement implementation
  - `research`: Exploration and analysis
- **title**: `$ARGUMENTS[1]` - Workflow title

### 2. Initialize Workspace | 初始化工作空间

```bash
# Create workflow directory
WORKFLOW_ID="WF-$(date +%Y%m%d)-$(date +%H%M)"
mkdir -p workflows/$WORKFLOW_ID

# Create spec directories if not exist
mkdir -p specs/{idea,requirements,technical,bug-fix}
mkdir -p tasks/$WORKFLOW_ID
```

### 3. Execute Workflow Steps | 执行工作流步骤

#### Step 1: Create Idea Specification | 创建想法规格

Use requirement-analyst agent:
使用需求分析师代理：

```
Use the requirement-analyst agent to create an idea specification for: "$TITLE"

This is a $WORKFLOW_TYPE workflow. Please create an initial idea specification with:
- Problem statement
- Proposed solution
- Value proposition
- Initial requirements
- Success criteria
```

#### Step 2: Convert to Requirements | 转换为需求

If not bug-fix:
如果不是Bug修复：

```
Use the requirement-analyst agent to convert the idea into detailed requirements.

Please expand on:
- Functional requirements
- Non-functional requirements
- User stories
- Acceptance criteria
- Constraints and assumptions
```

#### Step 3: Create Technical Specification | 创建技术规格

Use specification-writer agent:
使用规格书编写代理：

```
Use the specification-writer agent to create a technical specification.

Include:
- Architecture overview
- Component design
- API specifications
- Database schema
- Security considerations
- Implementation plan
```

#### Step 4: Decompose into Tasks | 分解为任务

Use task-analyst agent:
使用任务分析师代理：

```
Use the task-analyst agent to decompose the specification into tasks.

Consider:
- Task granularity
- Dependencies
- Effort estimates
- Resource requirements
- Timeline
```

#### Step 5: Initialize Tracking | 初始化跟踪

Create workflow tracking:
创建工作流跟踪：

```
Workflow: $TITLE ($WORKFLOW_ID)
Type: $WORKFLOW_TYPE
Started: $(date)
Status: active

Progress:
- [x] Idea specification
- [x] Requirements specification
- [x] Technical specification
- [x] Task decomposition
- [ ] Task assignment
- [ ] Implementation
- [ ] Testing
- [ ] Deployment
```

## Workflow Types | 工作流类型

### Feature Workflow | 功能工作流

For new features:
用于新功能：

```
Feature Workflow Phases:
1. Idea validation (1-2 days)
2. Requirements gathering (2-3 days)
3. Technical design (2-3 days)
4. Task breakdown (1 day)
5. Development (1-2 weeks)
6. Testing (3-5 days)
7. Deployment (1 day)

Total Duration: 2-3 weeks
```

### Bug-Fix Workflow | Bug修复工作流

For bug resolution:
用于Bug修复：

```
Bug-Fix Workflow Phases:
1. Bug report and analysis (1 day)
2. Root cause investigation (1-2 days)
3. Fix design (1 day)
4. Implementation (1-3 days)
5. Testing (1-2 days)
6. Hotfix deployment (0.5 day)

Total Duration: 3-7 days
```

### Improvement Workflow | 改进工作流

For enhancements:
用于改进：

```
Improvement Workflow Phases:
1. Current state analysis (1-2 days)
2. Improvement design (2-3 days)
3. Implementation plan (1 day)
4. Development (1 week)
5. Testing (2-3 days)
6. Gradual rollout (1 week)

Total Duration: 2-3 weeks
```

### Research Workflow | 研究工作流

For exploration:
用于探索：

```
Research Workflow Phases:
1. Research question definition (1 day)
2. Information gathering (3-5 days)
3. Analysis and synthesis (2-3 days)
4. Recommendation report (2 days)
5. Presentation (1 day)

Total Duration: 1-2 weeks
```

## Output Structure | 输出结构

### Created Files | 创建的文件

```
workflows/WF-20250125-1430/
├── workflow.md          # Main workflow tracking
├── specs/
│   ├── idea.md
│   ├── requirements.md
│   └── technical.md
├── tasks/
│   ├── TASK-001.task.md
│   ├── TASK-002.task.md
│   └── ...
└── reports/
    ├── progress.md
    └── metrics.md
```

### Workflow Dashboard | 工作流仪表板

```
┌─────────────────────────────────────────────────────────────┐
│ Workflow: User Dashboard (WF-20250125-1430)                 │
├─────────────────────┬───────────────────────────────────────┤
│ Type                │ feature                              │
│ Status              │ active                               │
│ Progress            │ ██████░░░░ 60%                        │
│ Started             │ 2025-01-25                            │
│ Estimated Complete  │ 2025-02-08                            │
├─────────────────────┼───────────────────────────────────────┤
│ Current Phase       │ Task Decomposition                   │
│ Next Milestone      │ First Task Assignment                │
│ Total Tasks         │ 12 (0 completed)                     │
└─────────────────────┴───────────────────────────────────────┘

Quick Actions:
/workflow status WF-20250125-1430
/task decompose SPEC-001 --save
/task assign SPEC-001 john
```

## Automation Features | 自动化功能

### Auto-Assignment | 自动分配

Based on team availability:
基于团队可用性：

```bash
# Check team workload
/workflow start feature "New Feature" --auto-assign
```

### Template Application | 模板应用

Use workflow templates:
使用工作流模板：

```bash
# Start with predefined template
/workflow start feature "API Integration" --template "microservice"
```

Available templates:
可用模板：

- **microservice**: Microservice architecture
- **mobile-app**: Mobile application
- **data-pipeline**: Data processing pipeline
- **ai-feature**: AI/ML integration

### Integration Setup | 集成设置

Automatically configure integrations:
自动配置集成：

```bash
# Create GitHub issues for tasks
/workflow start feature "New Feature" --create-issues

# Setup Jira project
/workflow start feature "New Feature" --jira-integration

# Configure CI/CD pipeline
/workflow start feature "New Feature" --setup-cicd
```

## Advanced Options | 高级选项

### Custom Workflow | 自定义工作流

Define custom workflow steps:
定义自定义工作流步骤：

```bash
/workflow start custom "Special Project" --config custom-workflow.yaml
```

### Parallel Execution | 并行执行

Run multiple workflow phases:
运行多个工作流阶段：

```bash
/workflow start feature "Complex Feature" --parallel
```

### Resource Planning | 资源规划

Automatically allocate resources:
自动分配资源：

```bash
/workflow start feature "Large Feature" --plan-resources
```

## Implementation Steps | 实施步骤

1. **Parse workflow type** and title
2. **Generate unique workflow ID**
3. **Create workspace structure**
4. **Execute workflow phases** based on type
5. **Invoke appropriate agents** for each phase
6. **Create task breakdown** using task-analyst
7. **Initialize tracking systems**
8. **Generate workflow dashboard**
9. **Configure notifications** if requested
10. **Display summary** and next steps

## Error Handling | 错误处理

- **Invalid workflow type**: Show valid types
- **Agent unavailable**: Continue with template
- **Permission issues**: Check directory permissions
- **Resource constraints**: Suggest alternatives