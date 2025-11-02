# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2025-10-20

### Added
- Initial release of XRPL Validator Health Monitor
- Real-time monitoring of rippled validator nodes
- Support for both Docker and native rippled deployments
- Interactive configuration wizard with automatic setup
- Comprehensive health metrics including:
  - Ledger synchronization status
  - Consensus participation tracking
  - Network peer connectivity
  - Resource usage (CPU, memory, PIDs)
- Automatic health classification (Stable/Watch/Trouble)
- Smooth, flicker-free terminal updates using tput
- JSON output mode for programmatic integration
- Configurable refresh intervals
- Local rippled detection and validation
- Auto-detection of rippled binary and config paths (native mode)
- Container discovery and listing (Docker mode)
- Process statistics for native deployments
- Beautiful terminal UI with colored output and box drawing
- Comprehensive documentation and troubleshooting guide

### Features
- **Multi-deployment support**: Works seamlessly with Docker containers or native installations
- **Zero-configuration**: Interactive setup on first run with smart defaults
- **Portable**: Can be run from any directory on the system
- **Health monitoring**: Tracks 20+ metrics across ledger, network, consensus, and resources
- **Real-time updates**: Smooth screen refresh without flicker
- **Flexible output**: Terminal UI or JSON for automation

### Technical Details
- Implements incremental verification methodology
- Uses rippled RPC API (server_info, peers, consensus_info, fetch_info)
- Terminal control with tput for smooth updates
- Bash 4.0+ compatible
- Dependencies: jq, docker (for Docker deployments)

### Documentation
- Complete README with installation instructions
- Metrics explanation guide
- Architecture diagrams and sequence flows
- Troubleshooting section
- Contributing guidelines
- MIT License

## [Unreleased]

### Planned Features
- Remote rippled monitoring support
- Alert notifications (email, webhook, SMS)
- Historical data logging and graphing
- Multiple validator monitoring
- Web dashboard interface
- Prometheus exporter compatibility
- systemd service integration
- Automated health reports

---

[1.0.0]: https://github.com/realgrapedrop/xrpl-rippled-watch/releases/tag/v1.0.0
