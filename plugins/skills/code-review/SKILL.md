# Code Review Skill

Enhanced code review capabilities focusing on quality, security, and maintainability.

## Usage

```
Use the code-review skill to review my recent changes
```

## Review Areas

### 1. Code Quality
- Readability and clarity
- Adherence to coding standards
- Proper error handling
- Resource management

### 2. Security
- Input validation
- Authentication/authorization
- Data exposure risks
- Dependency vulnerabilities

### 3. Performance
- Algorithm efficiency
- Memory usage
- Database queries
- Caching opportunities

### 4. Architecture
- SOLID principles
- Design patterns
- Coupling and cohesion
- Scalability

## Checklist

Before submitting a review, ensure:

- [ ] Code follows style guidelines
- [ ] No hardcoded secrets or keys
- [ ] Proper error handling exists
- [ ] Tests are included where appropriate
- [ ] Documentation is updated
- [ ] Performance implications considered
- [ ] Security best practices followed

## Review Process

1. **Understand Context**: Review the PR description and changes
2. **Automated Checks**: Run linting, tests, and security scans
3. **Code Analysis**: Review each changed file
4. **Feedback**: Provide constructive, actionable feedback
5. **Verification**: Confirm issues are addressed

## Feedback Types

- **Must Fix**: Blocking issues
- **Should Fix**: Important improvements
- **Consider**: Optional enhancements

## Integration

Works seamlessly with:
- `code-reviewer` agent for automated reviews
- Git hooks for pre-commit checks
- CI/CD pipelines for automated validation