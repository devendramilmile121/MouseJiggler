# Changelog

All notable changes to MouseJiggler will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Automated GitHub Actions workflow for releases
- Cross-platform support (Windows x64/x86, Linux x64)
- Self-contained executable publishing
- Version management and release automation

### Changed
- Improved project structure with proper versioning
- Enhanced build configuration for optimized executables

## [1.0.0] - 2025-11-12

### Added
- Initial release of MouseJiggler
- Smart idle detection (60-second threshold)
- Non-intrusive key press simulation (Scroll Lock, Shift)
- Random timing for natural behavior
- Console-based interface with real-time status
- Windows API integration for idle time detection
- Cross-platform .NET 9.0 implementation

### Features
- Automatic activity simulation when idle
- Configurable check intervals (15 seconds ±3 seconds)
- Non-interfering key combinations
- Lightweight and efficient operation
- Self-contained executable (no .NET installation required)

[Unreleased]: https://github.com/username/mousejiggler/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/username/mousejiggler/releases/tag/v1.0.0