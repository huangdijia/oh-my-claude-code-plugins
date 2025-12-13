---
name: spec:list
version: "1.0.0"
description: 列出所有规格文档，支持可选过滤。Lists all specification documents with optional filtering.
tags: [spec, listing, filtering, documentation]
allowed-tools:
  - Read
  - Glob
  - Bash
argument-hint: [filter-type:filter-value]
arguments:
  - name: filter
    type: string
    required: false
    description: Filter specifications in format type:value or show all if not provided
    pattern: "^(type|status|priority|assignee|tags|created):.+$|^$"
examples:
  - command: "/spec list"
    description: 列出所有规格文档 | List all specifications
  - command: "/spec list type:requirements"
    description: 只显示需求规格 | Show only requirements specifications
  - command: "/spec list status:draft"
    description: 只显示草稿状态的规格 | Show only draft specifications
  - command: "/spec list assignee:john"
    description: 显示john负责的规格 | Show specifications assigned to john
  - command: "/spec list priority:high"
    description: 显示高优先级规格 | Show high priority specifications
categories: [documentation, planning, management]
author: "Deeka Wong"
license: MIT
---

# List Specifications | 列出规格文档

List specifications with filter: **$ARGUMENTS**
列出规格：**$ARGUMENTS**

## Current State | 当前状态

- Working directory: !`pwd`
- Specs directory exists: !`test -d specs && echo "✅ Yes" || echo "❌ No"`
- Total specifications found: !`find specs -name "*.md" -type f 2>/dev/null | wc -l`

## Task | 任务

Parse filter arguments and list specifications:
解析过滤参数并列出规格：

### 1. Parse Filter Arguments | 解析过滤参数

Parse `$ARGUMENTS` to extract:
解析 `$ARGUMENTS` 提取：

- **No arguments**: Show all specifications
- **filter-type**: One of: type, status, priority, assignee, tags, created
- **filter-value**: Value to filter by

### 2. Search for Specifications | 搜索规格文件

```bash
# Find all specification files
find specs -name "*.md" -type f | sort
```

### 3. Extract Metadata | 提取元数据

For each specification file, extract:
为每个规格文件提取：

- spec_id from frontmatter
- title from frontmatter
- spec_type from frontmatter
- status from frontmatter
- priority from frontmatter
- assignee from frontmatter
- created_date from frontmatter
- tags from frontmatter

### 4. Apply Filters | 应用过滤器

Based on filter-type, apply appropriate filtering:
根据过滤类型应用相应过滤：

- **type**: Filter by spec_type
- **status**: Filter by status
- **priority**: Filter by priority
- **assignee**: Filter by assignee
- **tags**: Filter by tags (contains)
- **created**: Filter by created_date (supports YYYY, YYYY-MM)

### 5. Format Output | 格式化输出

Display results in table format:
以表格格式显示结果：

```markdown
┌─────────┬──────────────────────┬─────────────┬─────────┬──────────┬─────────┐
│ Spec ID │ Title                │ Type        │ Status  │ Priority │ Assignee │
├─────────┼──────────────────────┼─────────────┼─────────┼──────────┼─────────┤
│ SPEC-001│ User Authentication  │ requirements│ draft   │ high     │ john     │
│ SPEC-002│ Login Bug Fix        │ bug-fix     │ approved│ critical │ sarah    │
└─────────┴──────────────────────┴─────────────┴─────────┴──────────┴─────────┘
```

## Filter Details | 过滤器详情

### By Type | 按类型过滤

- `type:idea` - Initial ideas and concepts
- `type:requirements` - Detailed requirements
- `type:technical` - Technical design specifications
- `type:bug-fix` - Bug reports and fix specifications

### By Status | 按状态过滤

- `status:draft` - Work in progress
- `status:review` - Under review
- `status:approved` - Approved for implementation
- `status:in-progress` - Currently being implemented
- `status:completed` - Implementation complete
- `status:archived` - No longer active

### By Priority | 按优先级过滤

- `priority:low` - Low priority
- `priority:medium` - Medium priority
- `priority:high` - High priority
- `priority:critical` - Critical priority

### By Assignee | 按负责人过滤

- `assignee:username` - Assigned to specific user
- `assignee:unassigned` - Not assigned to anyone

### By Tags | 按标签过滤

- `tags:auth` - Contains 'auth' tag
- `tags:frontend` - Contains 'frontend' tag
- Multiple tags supported with comma separation

### By Created Date | 按创建日期过滤

- `created:2025` - Created in 2025
- `created:2025-01` - Created in January 2025
- `created:2025-01-15` - Created on specific date

## Implementation Steps | 实施步骤

1. **Check specs directory exists** - Exit with error if not found
2. **Find all markdown files** - Recursively search specs directory
3. **Read frontmatter** - Extract YAML metadata from each file
4. **Parse filter arguments** - Extract filter type and value
5. **Apply filter logic** - Filter specifications based on criteria
6. **Sort results** - Sort by spec_id or created_date
7. **Format table** - Create aligned table output
8. **Display summary** - Show count and filter applied

## Error Handling | 错误处理

- **No specs found**: Display appropriate message
- **Invalid filter type**: Show valid filter types
- **File read errors**: Skip problematic files with warning
- **Invalid YAML**: Handle malformed frontmatter gracefully

## Output Options | 输出选项

### Verbose Mode | 详细模式

Add `-v` or `--verbose` flag for additional details:
添加 `-v` 或 `--verbose` 标志获取更多详情：

```markdown
SPEC-001 | User Authentication | requirements | draft | high | john | 2025-01-15 | ["auth", "security"]
```

### Export Format | 导出格式

Support export to CSV or JSON:
支持导出为 CSV 或 JSON：

```bash
/spec list --format csv > specs.csv
/spec list type:requirements --format json > requirements.json
```
