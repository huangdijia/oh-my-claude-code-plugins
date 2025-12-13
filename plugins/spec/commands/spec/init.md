---
name: spec:init
version: "1.0.0"
description: 初始化新的规格文档。根据选定的类型创建新的规格文档。Creates a new specification document based on the selected type.
tags: [spec, initialization, documentation, workflow]
allowed-tools:
  - Write
  - Read
  - Bash
  - TodoWrite
argument-hint: <spec-type> <spec-title> [spec-id]
arguments:
  - name: spec-type
    type: string
    required: true
    description: Type of specification to create (idea, requirements, technical, bug-fix)
    pattern: "^(idea|requirements|technical|bug-fix)$"
  - name: spec-title
    type: string
    required: true
    description: Brief title for the specification
  - name: spec-id
    type: string
    required: false
    description: Optional custom ID (auto-generated if not provided)
examples:
  - command: "/spec init requirements \"User Authentication System\""
    description: 创建用户认证系统需求规格 | Create user authentication system requirements
  - command: "/spec init bug-fix \"Login page crashes on Safari\""
    description: 创建Safari登录页面崩溃Bug修复规格 | Create bug fix spec for Safari login crash
  - command: "/spec init technical \"Payment Gateway Integration\" PAY-001"
    description: 创建支付网关技术设计规格 | Create payment gateway technical design spec
categories: [documentation, planning, development]
author: "Deeka Wong"
license: MIT
---

# Initialize Specification | 初始化规格文档

Create new specification: **$ARGUMENTS**
创建新规格：**$ARGUMENTS**

## Current State | 当前状态

- Working directory: !`pwd`
- Specs directory exists: !`test -d specs && echo "✅ Yes" || echo "❌ No"`
- Current specs count: !`find specs -name "*.md" -type f 2>/dev/null | wc -l`

## Task | 任务

Create a new specification document with the following steps:
按照以下步骤创建新的规格文档：

### 1. Validate Arguments | 验证参数

- **Check spec type**: Verify `$ARGUMENTS[0]` is one of: idea, requirements, technical, bug-fix
  - ✅ Valid: `idea`, `requirements`, `technical`, `bug-fix`
  - ❌ Invalid: Any other value
- **Validate title**: Ensure `$ARGUMENTS[1]` is provided and meaningful
- **Generate spec ID**: If not provided, generate auto-incremented ID (e.g., SPEC-001)

### 2. Prepare Directory Structure | 准备目录结构

```bash
# Create specs directory if not exists
mkdir -p specs
mkdir -p specs/active
mkdir -p specs/completed
mkdir -p specs/archived
```

### 3. Load Template | 加载模板

Based on spec type, load appropriate template:
根据规格类型加载相应模板：

- **idea**: Basic idea/concept template
- **requirements**: Detailed requirements template
- **technical**: Technical design template
- **bug-fix**: Bug report and fix template

### 4. Create Specification File | 创建规格文件

Create file with format: `specs/{spec-type}/{spec-id}-{slug-title}.md`
创建格式为：`specs/{spec-type}/{spec-id}-{slug-title}.md` 的文件

File structure:
文件结构：

```yaml
---
spec_id: [AUTO-GENERATED]
spec_type: [TYPE]
status: draft
priority: [medium/high/low]
assignee: [optional]
created_date: [CURRENT_DATE]
updated_date: [CURRENT_DATE]
title: [TITLE]
tags: [auto-generated]
---
```

### 5. Initialize Task Tracking | 初始化任务跟踪

- Create TODO list if specification is complex
- Add initial task: "Review and complete specification"
- Set initial due date (7 days from creation)

### 6. Post-Creation Actions | 创建后操作

- Display file path and next steps
- Suggest related commands:
  - `/spec status $SPEC_ID` - Check specification status
  - `/spec validate $SPEC_ID` - Validate specification format
  - `/task decompose $SPEC_ID` - Decompose into tasks

## Template Contents | 模板内容

### Idea Template | 想法模板

```markdown
# Idea: [TITLE]

## Overview | 概述
Brief description of the idea

## Problem Statement | 问题陈述
What problem does this solve?

## Proposed Solution | 建议方案
High-level solution approach

## Value Proposition | 价值主张
Benefits and business value

## Next Steps | 下一步
- [ ] Feasibility analysis
- [ ] Requirements gathering
- [ ] Technical assessment
```

### Requirements Template | 需求模板

```markdown
# Requirements: [TITLE]

## Executive Summary | 执行摘要
Brief overview of requirements

## Stakeholders | 干系人
List of stakeholders and their needs

## Functional Requirements | 功能需求
Detailed functional requirements

## Non-Functional Requirements | 非功能需求
Performance, security, usability requirements

## Acceptance Criteria | 验收标准
Definition of done

## Dependencies | 依赖关系
External dependencies and constraints
```

### Technical Template | 技术模板

```markdown
# Technical Design: [TITLE]

## Architecture Overview | 架构概述
High-level system architecture

## Components | 组件设计
Detailed component design

## API Specifications | API规格
API endpoints and contracts

## Database Design | 数据库设计
Schema and relationships

## Security Considerations | 安全考虑
Authentication, authorization, data protection

## Implementation Plan | 实施计划
Development phases and timeline
```

### Bug-Fix Template | Bug修复模板

```markdown
# Bug Fix: [TITLE]

## Bug Description | Bug描述
Detailed bug description

## Reproduction Steps | 重现步骤
Steps to reproduce the issue

## Environment | 环境
OS, browser, version information

## Root Cause Analysis | 根因分析
Underlying cause of the bug

## Fix Strategy | 修复策略
Proposed solution approach

## Testing Plan | 测试计划
Test cases to verify the fix
```

## Validation Steps | 验证步骤

1. Verify file created successfully
2. Check frontmatter is valid YAML
3. Validate required fields are present
4. Confirm file follows naming convention
5. Test TODO list initialization

## Error Handling | 错误处理

- Invalid spec type: Show valid options and exit
- Missing title: Prompt for title and retry
- File exists: Ask to overwrite or use different ID
- Permission denied: Check directory permissions
