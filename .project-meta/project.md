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
