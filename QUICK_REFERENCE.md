# Quick Reference Card

## Installation

```bash
# Quick install
curl -O https://raw.githubusercontent.com/realgrapedrop/xrpl-rippled-watch-health-monitor/main/rippled-watch.sh
chmod +x rippled-watch.sh
./rippled-watch.sh

# Clone repository
git clone https://github.com/realgrapedrop/xrpl-rippled-watch-health-monitor.git
cd xrpl-rippled-watch-health-monitor
./rippled-watch.sh

# System-wide install
git clone https://github.com/realgrapedrop/xrpl-rippled-watch-health-monitor.git
cd xrpl-rippled-watch-health-monitor
sudo ./install.sh
rippled-watch
```

## Basic Commands

```bash
# Start monitoring (uses config)
./rippled-watch.sh

# Fast refresh (1 second)
./rippled-watch.sh --interval 1

# Reconfigure settings
./rippled-watch.sh --reconfig

# JSON output for logging
./rippled-watch.sh --json | tee monitor.log

# Show help
./rippled-watch.sh --help
```

## First Run Setup

**Questions you'll be asked:**

1. **Deployment type:** Docker (1) or Native (2)?
2. **Container name:** Default: `rippledvalidator`
3. **HTTP RPC Port:** Default: `5005`
4. **WebSocket Port:** Default: `6006`
5. **Peer Port:** Default: `51235`
6. **Refresh interval:** Default: `5` seconds

## Health Status Quick Guide

| Status | Icon | Meaning | Action |
|--------|------|---------|--------|
| **STABLE** | ✅ | All systems normal | Monitor |
| **WATCH** | ⚠️ | Minor issues detected | Investigate |
| **TROUBLE** | ❌ | Critical issues | Immediate attention |

## Key Metrics at a Glance

### Healthy Validator

```
Server State:      proposing
Ledger Age:        < 20s
Ledgers/min:       ~60
Peers:             > 10
Load Factor:       1
Proposing:         true
Validating:        true
Synced:            true
```

### Warning Signs

```
Server State:      tracking/syncing
Ledger Age:        > 20s
Ledgers/min:       < 5
Peers:             < 3
Load Factor:       > 4
P90 RTT:           > 300ms
```

## Common Issues

### Container Not Running
```bash
docker ps | grep rippled
docker start rippledvalidator
```

### RPC Not Responding
```bash
docker logs rippledvalidator --tail 50
# Wait 30 seconds for startup
```

### Wrong Ports
```bash
./rippled-watch.sh --reconfig
# Update port settings
```

### Permission Denied
```bash
chmod +x rippled-watch.sh
# or
sudo usermod -aG docker $USER
# then logout/login
```

## Configuration File

**Location:** Same directory as script

**File:** `rippled-watch.conf`

```bash
# View config
cat rippled-watch.conf

# Edit config
nano rippled-watch.conf

# Delete config (will re-prompt)
rm rippled-watch.conf
./rippled-watch.sh
```

## Uninstallation

```bash
# Local installation
rm rippled-watch.sh rippled-watch.conf

# System-wide installation
sudo rippled-watch-uninstall
# or
sudo rm /usr/local/bin/rippled-watch
```

## Keyboard Shortcuts

| Key | Action |
|-----|--------|
| **Ctrl+C** | Exit monitor |
| **Ctrl+Z** | Suspend (then `fg` to resume) |

## Quick Diagnostics

```bash
# Test rippled RPC manually
docker exec rippledvalidator rippled server_info

# Check container health
docker inspect rippledvalidator | grep -A5 Health

# View container logs
docker logs -f rippledvalidator

# Check system resources
docker stats rippledvalidator --no-stream
```

## Server State Progression

```
Normal startup sequence:
disconnected → connected → syncing → tracking → full → validating → proposing
                                                                          ↑
                                                                     Target
```

## Rippled RPC Endpoints Used

```bash
# Server information
server_info      # State, ledger, load

# Peer connections
peers           # Network connectivity

# Consensus participation
consensus_info  # Proposing, validating

# Ledger fetching
fetch_info      # Download status
```

## Integration Examples

### Log to file
```bash
./rippled-watch.sh --json >> /var/log/rippled-watch.log
```

### Run in background
```bash
nohup ./rippled-watch.sh --json > watch.log 2>&1 &
```

### Monitor multiple validators
```bash
# Terminal 1
./rippled-watch.sh --container validator1

# Terminal 2
./rippled-watch.sh --container validator2
```

### Alert on issues
```bash
./rippled-watch.sh --json | while read line; do
  if echo "$line" | jq -e '.health.status == "trouble"' >/dev/null; then
    echo "ALERT: Validator in trouble!" | mail -s "Alert" admin@example.com
  fi
done
```

## Useful Aliases

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Quick start
alias rwm='cd ~/xrpl-rippled-watch-health-monitor && ./rippled-watch.sh'

# Fast refresh
alias rwf='cd ~/xrpl-rippled-watch-health-monitor && ./rippled-watch.sh --interval 1'

# JSON output
alias rwj='cd ~/xrpl-rippled-watch-health-monitor && ./rippled-watch.sh --json'
```

## Getting Help

- **GitHub Issues:** [Report bugs or request features](https://github.com/realgrapedrop/xrpl-rippled-watch-health-monitor/issues)
- **GitHub Discussions:** [Ask questions](https://github.com/realgrapedrop/xrpl-rippled-watch-health-monitor/discussions)
- **XRPL Docs:** https://xrpl.org/
- **Script Help:** `./rippled-watch.sh --help`

---

**Pro Tip:** Use `--interval 1` for rapid monitoring during troubleshooting, and `--interval 10` or higher for normal passive monitoring to reduce resource usage.
