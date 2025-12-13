---
name: spec:validate
version: "1.0.0"
description: 验证规格文档的完整性和格式。Validates a specification document for completeness and correct format.
tags: [spec, validation, quality, check]
allowed-tools:
  - Read
  - Glob
  - Bash
argument-hint: [spec-id or file-path]
arguments:
  - name: target
    type: string
    required: false
    description: Specification ID or file path to validate (validates all if not provided)
    pattern: "^[A-Z]+-[0-9]+$|^specs/.+\.md$|^$"
examples:
  - command: "/spec validate SPEC-001"
    description: 验证SPEC-001规格 | Validate SPEC-001 specification
  - command: "/spec validate specs/user-auth.md"
    description: 验证指定路径的规格 | Validate specification at path
  - command: "/spec validate"
    description: 验证所有规格文档 | Validate all specification documents
categories: [documentation, quality, validation]
author: "Deeka Wong"
license: MIT
---

# Validate Specification | 验证规格文档

Validate specification: **$ARGUMENTS**
验证规格：**$ARGUMENTS**

## Current State | 当前状态

- Working directory: !`pwd`
- Specs directory exists: !`test -d specs && echo "✅ Yes" || echo "❌ No"`
- Total specifications to validate: !`test -n "$ARGUMENTS" && echo "1" || find specs -name "*.md" -type f 2>/dev/null | wc -l`

## Task | 任务

Perform comprehensive validation:
执行全面验证：

### 1. Parse Arguments | 解析参数

- **spec-id**: Find and validate specific specification
- **file-path**: Validate specification at given path
- **no arguments**: Validate all specifications in specs directory

### 2. Locate Specifications | 定位规格

```bash
# If spec-id provided
find specs -name "*${ARGUMENTS}*" -type f | head -1

# If file-path provided, verify exists
test -f "$ARGUMENTS"

# If no arguments, find all specs
find specs -name "*.md" -type f
```

### 3. Validation Checks | 验证检查

#### 3.1 Frontmatter Validation | 前置元数据验证

Check required fields based on spec type:
根据规格类型检查必填字段：

**Required Fields by Type:**

- **idea**: spec_id, spec_type, status, created_date, title
- **requirements**: spec_id, spec_type, status, priority, created_date, title
- **technical**: spec_id, spec_type, status, priority, assignee, created_date, title
- **bug-fix**: spec_id, spec_type, status, priority, severity, created_date, title

#### 3.2 Document Structure | 文档结构

Validate structure completeness:
验证结构完整性：

```yaml
# Frontmatter completeness
spec_id: ✓/✗
spec_type: ✓/✗
status: ✓/✗
priority: ✓/✗ (for non-idea)
assignee: ✓/✗ (for technical)
severity: ✓/✗ (for bug-fix)
created_date: ✓/✗
updated_date: ✓/✗
title: ✓/✗
tags: ✓/✗

# Document sections
## Overview/Description ✓/✗
## Requirements/Details ✓/✗
## Acceptance Criteria ✓/✗ (if applicable)
## Dependencies ✓/✗ (if any)
```

#### 3.3 Format Validation | 格式验证

- **YAML syntax**: Valid frontmatter
- **Markdown structure**: Proper heading hierarchy
- **Link references**: All links resolve correctly
- **Image references**: Images exist and accessible

#### 3.4 Content Validation | 内容验证

- **Title consistency**: Title in frontmatter matches H1
- **Date format**: YYYY-MM-DD format
- **Status values**: One of allowed values
- **Priority values**: low, medium, high, critical
- **Severity values**: low, medium, high, critical

### 4. Validation Report | 验证报告

```
┌─────────────────────────────────────────────────────────────┐
│ Validation Report: SPEC-001                                │
├─────────────────────┬───────────────────────────────────────┤
│ Overall Status       │ ✓ PASSED (with warnings)             │
│ Frontmatter          │ ✓ PASSED                              │
│ Document Structure   │ ⚠ WARNING - Missing Dependencies     │
│ Link Validity        │ ✓ PASSED                              │
│ Format               │ ✓ PASSED                              │
├─────────────────────┼───────────────────────────────────────┤
│ Issues Found         │ 1 warning, 0 errors                   │
│ Recommendations      │ Add dependencies section             │
└─────────────────────┴───────────────────────────────────────┘

Detailed Issues:
⚠ WARNING [Line 45]: No dependencies section found
   Recommendation: Add Dependencies section even if "None"

```

## Validation Rules | 验证规则

### Status Values | 状态值

Valid status values:
有效状态值：

- `draft`
- `review`
- `approved`
- `in-progress`
- `testing`
- `completed`
- `blocked`
- `archived`

### Priority Levels | 优先级

Valid priority values:
有效优先级值：

- `low`
- `medium`
- `high`
- `critical`

### Severity Levels | 严重性

Valid severity values (for bug-fix):
有效严重性值（用于Bug修复）：

- `low`
- `medium`
- `high`
- `critical`

### Date Format | 日期格式

Must be in YYYY-MM-DD format:
必须使用 YYYY-MM-DD 格式：

- ✅ Valid: `2025-01-15`
- ✗ Invalid: `15/01/2025`, `Jan 15, 2025`

## Error Categories | 错误类别

### Errors | 错误

- **Missing required fields**: Critical issues
- **Invalid YAML syntax**: Cannot parse frontmatter
- **Broken links**: References don't exist
- **Invalid values**: Not in allowed list

### Warnings | 警告

- **Missing optional fields**: Should be present
- **Inconsistent formatting**: Style issues
- **Empty sections**: Sections with no content
- **Outdated information**: Old dates or status

### Info | 信息

- **Suggestions**: Improvement recommendations
- **Best practices**: Following conventions
- **Optimizations**: Better ways to structure

## Batch Validation | 批量验证

When validating all specifications:
验证所有规格时：

```
┌─────────────────────────────────────────────────────────────┐
│ Batch Validation Summary                                    │
├─────────────┬─────────┬─────────┬─────────┬─────────────────┤
│ Total Specs │ Passed  │ Warnings│ Errors  │ Elapsed Time    │
├─────────────┼─────────┼─────────┼─────────┼─────────────────┤
│ 12          │ 10      │ 2       │ 0       │ 2.3s            │
└─────────────┴─────────┴─────────┴─────────┴─────────────────┘

Failed Validations:
- SPEC-007: Missing severity field (bug-fix type)
- SPEC-011: Invalid status value "in-review"

Recommendations:
1. Run `/spec validate SPEC-007 --fix` to auto-fix issues
2. Update status field in SPEC-011 to "review"
```

## Auto-Fix Option | 自动修复选项

Add `--fix` flag for automatic fixes:
添加 `--fix` 标志进行自动修复：

```bash
/spec validate SPEC-001 --fix
```

Auto-fixable issues:
可自动修复的问题：

- Add missing optional fields with defaults
- Fix date formats
- Normalize status values
- Sort tags alphabetically
- Add empty sections with placeholder text

## Implementation Steps | 实施步骤

1. **Parse input arguments** and determine target
2. **Locate specification file(s)**
3. **Parse YAML frontmatter** safely
4. **Validate required fields** based on type
5. **Check document structure** and sections
6. **Validate links** and references
7. **Generate validation report** with issues
8. **Apply auto-fixes** if `--fix` flag provided
9. **Display summary** and recommendations

## Exit Codes | 退出代码

- `0`: All validations passed
- `1`: Warnings found
- `2`: Errors found
- `3`: Critical errors (cannot continue)
