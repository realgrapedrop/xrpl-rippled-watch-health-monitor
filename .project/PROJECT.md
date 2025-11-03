# XRPL Validator Health Monitor

## Project Overview

This project provides real-time monitoring for XRPL (XRP Ledger) validator nodes through a bash-based health monitoring script (`rippled-watch.sh`).

## Purpose

To give XRPL validator operators a comprehensive, real-time view of their validator's health, performance, and consensus participation with automatic health classification and alerting.

## Key Components

### Main Script: `rippled-watch.sh`
- Monitors rippled validator instances (Docker or native deployments)
- Fetches metrics via rippled RPC commands
- Displays real-time TUI or outputs JSON for logging/monitoring systems
- Auto-configures on first run with persistent config file

## Architecture

### Deployment Support
- **Docker**: Monitors containerized rippled via `docker exec` RPC calls
- **Native**: Monitors system-installed rippled via direct binary calls

### Data Collection
- **RPC Methods Used**:
  - `server_info` - Core server state, ledger info, load factor
  - `peers` - Network connectivity and latency metrics
  - `consensus_info` - Consensus participation status
  - `fetch_info` - Ledger fetch performance
- **System Stats**: Docker stats API or native process metrics (CPU, memory, PIDs)

### Health Classification Algorithm
Evaluates multiple factors to classify validator health:
- **STABLE**: Actively proposing/validating with healthy metrics
- **WATCH**: Minor issues or warming up (degraded performance)
- **TROUBLE**: Critical issues (offline, stale, isolated)

## Configuration

### Config File: `rippled-watch.conf`
- Auto-generated on first run
- Stores deployment type, ports, container/binary paths, refresh interval
- Can be regenerated with `--reconfig` flag

### Default Values
- Interval: 5 seconds
- HTTP Port: 5005
- WebSocket Port: 6006
- Peer Port: 51235
- Container: rippledvalidator

## Key Metrics Tracked

### Ledger Health
- Sequence number and age
- Ledgers per minute (calculated from sequence progression)
- Complete ledger ranges

### Network Health
- Peer count (total, inbound, outbound)
- P90 latency to peers
- Server state (proposing, validating, tracking, syncing, etc.)

### Consensus Participation
- Proposing status
- Validating status
- Sync status
- Proposer counts
- Convergence time

### Performance
- Load factor
- Inflight ledger fetches
- Fetch timeouts
- CPU and memory usage

## Usage Patterns

### Interactive Monitoring
Default TUI mode for operators watching validator health in real-time

### Logging/Alerting
JSON mode (`--json`) for integration with:
- Log aggregation (e.g., Elasticsearch, Loki)
- Monitoring dashboards (e.g., Grafana)
- Alerting systems (e.g., Prometheus Alertmanager)

## Code Style & Standards

- Pure bash (no external languages)
- POSIX-compliant where possible
- Defensive programming (handle missing data gracefully)
- Clear separation of concerns (config, data collection, display, health logic)
- Both structured (JSON) and human-readable (TUI) outputs

## Git Commit Guidelines

### Attribution Policy
- **DO NOT** include AI assistant attribution in commit messages
- **DO NOT** add `Co-Authored-By: Claude` or similar AI attribution
- **DO NOT** reference AI tools in commit message bodies
- All commits should be attributed solely to the project owner (realgrapedrop)

### Commit Message Format
```
Brief description of changes

- Bullet point details of what changed
- Technical implementation notes
- Bug fixes or feature additions
```

**Good Example:**
```
Fix config file location for system-wide installation

- Save config to ~/.config/rippled-watch.conf when installed system-wide
- Use local directory when running from source
- Create ~/.config directory if it doesn't exist
```

**Bad Example (DO NOT DO THIS):**
```
Fix config file location

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>
```

### Why No AI Attribution?
- Keeps git history clean and professional
- Maintains clear project ownership
- Prevents contributor graph pollution
- GitHub caches contributor data aggressively (can take days/weeks to clear)

### Working with AI Assistants
- AI tools (like Claude Code) are helpful development aids
- Use them freely for coding, debugging, and problem-solving
- This `.project/PROJECT.md` file helps AI understand project context
- Just don't add AI attribution to commits pushed to GitHub

## Dependencies

- `bash` - Shell interpreter
- `jq` - JSON parsing and manipulation
- `docker` - For Docker deployment monitoring
- `tput` - Terminal control for TUI
- `rippled` - Must be running locally (same machine)

## Future Enhancements (Potential)

- Remote monitoring support
- Historical data tracking
- Alert thresholds and notifications
- Web-based dashboard
- Multi-validator monitoring
- Prometheus exporter mode
