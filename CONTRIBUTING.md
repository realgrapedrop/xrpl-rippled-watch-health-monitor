# Contributing to XRPL Validator Health Monitor

Thank you for your interest in contributing! This document provides guidelines and instructions for contributing to the project.

## 🎯 How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues to avoid duplicates. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce**
- **Expected vs actual behavior**
- **Screenshots** (if applicable)
- **Environment details:**
  - OS and version
  - Script version
  - rippled version
  - Deployment type (Docker/native)

### Suggesting Enhancements

Enhancement suggestions are welcome! Please provide:

- **Clear use case** - Why is this enhancement needed?
- **Proposed solution** - How should it work?
- **Alternatives considered** - Other approaches you've thought about
- **Additional context** - Screenshots, examples, etc.

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch** - `git checkout -b feature/amazing-feature`
3. **Make your changes**
4. **Test thoroughly** - Ensure it works with both Docker and native deployments
5. **Commit with clear messages** - Follow conventional commits format
6. **Push to your fork** - `git push origin feature/amazing-feature`
7. **Open a Pull Request**

## 🧪 Testing Guidelines

### Manual Testing

Before submitting, test your changes with:

```bash
# Docker deployment
./rippled-watch.sh --interval 1

# Test reconfiguration
./rippled-watch.sh --reconfig

# Test JSON mode
./rippled-watch.sh --json

# Test with different intervals
./rippled-watch.sh --interval 5
./rippled-watch.sh --interval 10
```

### Test Checklist

- [ ] Script runs without errors
- [ ] Config creation works
- [ ] Docker deployment works
- [ ] Native deployment works (if applicable)
- [ ] Display updates smoothly
- [ ] JSON output is valid
- [ ] Help text is accurate
- [ ] No unbound variables
- [ ] Works with different terminal sizes

## 📝 Code Style

### Bash Style Guidelines

- **Use 4 spaces** for indentation (no tabs)
- **Use meaningful variable names** - `ledger_seq` not `ls`
- **Quote variables** - `"$variable"` not `$variable`
- **Use functions** for repeated logic
- **Add comments** for complex sections
- **Use `set -uo pipefail`** for error handling

### Example

```bash
# Good
process_ledger_data() {
    local ledger_seq="$1"
    local ledger_age="$2"
    
    if [ "$ledger_age" -gt 20 ]; then
        echo "${R}Ledger is stale${RS}"
        return 1
    fi
    
    echo "Processing ledger: $ledger_seq"
}

# Avoid
process() {
    ls=$1
    la=$2
    [ $la -gt 20 ] && echo "stale" && return 1
    echo "Processing: $ls"
}
```

## 🏗️ Development Workflow

### Setting Up Development Environment

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/rippled-watch.git
cd rippled-watch

# Add upstream remote
git remote add upstream https://github.com/ORIGINAL_OWNER/rippled-watch.git

# Create a feature branch
git checkout -b feature/my-feature
```

### Making Changes

1. **Make incremental changes** - Small, focused commits
2. **Test after each change** - Catch issues early
3. **Update documentation** - Keep README in sync
4. **Follow the methodology** - Build, test, verify, document

### Commit Messages

Use conventional commits format:

```
type(scope): subject

body (optional)

footer (optional)
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding tests
- `chore`: Maintenance tasks

Examples:

```
feat(health): add network latency threshold warning

Add a warning when P90 RTT exceeds 500ms to catch network issues earlier.

Closes #42
```

```
fix(display): prevent screen flicker on rapid updates

Use tput home instead of clear to update in-place, eliminating flicker
when using 1-second refresh intervals.
```

## 🐛 Debugging

### Enable Verbose Mode

Add to script for debugging:

```bash
set -x  # Print commands as they execute
```

### Common Issues

**Problem:** Script exits unexpectedly

**Debug:**
```bash
bash -x ./rippled-watch.sh --interval 1 2>&1 | tee debug.log
```

**Problem:** RPC calls failing

**Test manually:**
```bash
docker exec rippledvalidator rippled --conf /opt/ripple/etc/rippled.cfg server_info
```

## 📋 Feature Request Template

When requesting features, please use this template:

```markdown
## Feature Description
[Clear description of the feature]

## Use Case
[Why is this feature needed?]

## Proposed Implementation
[How should it work?]

## Alternatives Considered
[Other approaches you've thought about]

## Additional Context
[Screenshots, examples, references]
```

## 🔍 Code Review Process

All submissions require review. We look for:

1. **Functionality** - Does it work as intended?
2. **Code quality** - Is it readable and maintainable?
3. **Testing** - Has it been tested adequately?
4. **Documentation** - Are changes documented?
5. **Backward compatibility** - Does it break existing setups?

## 🎓 Resources

- [Bash Style Guide](https://google.github.io/styleguide/shellguide.html)
- [XRPL Documentation](https://xrpl.org/docs.html)
- [rippled API Reference](https://xrpl.org/public-api-methods.html)

## 💬 Getting Help

- **Questions:** Open a [Discussion](https://github.com/YOUR_USERNAME/rippled-watch/discussions)
- **Issues:** File a [Bug Report](https://github.com/YOUR_USERNAME/rippled-watch/issues)
- **Chat:** Join the XRPL Discord

## 🏆 Recognition

Contributors will be recognized in:
- README acknowledgments
- Release notes
- Git commit history

Thank you for contributing to making validator monitoring better! 🚀
