# MouseJiggler - Smart Activity Keeper

A lightweight, non-intrusive activity simulator that prevents your system from going idle or entering sleep mode. Perfect for maintaining active status during meetings, downloads, or any situation where you need to keep your computer awake.

## Features

- **Smart Idle Detection**: Automatically detects when you're away and simulates activity
- **Non-Intrusive**: Uses Scroll Lock and Shift key presses that don't interfere with applications
- **Configurable**: 60-second idle threshold with 15-second check intervals
- **Natural Behavior**: Random intervals and key combinations to appear authentic
- **Lightweight**: Self-contained executable with minimal resource usage
- **Cross-Platform**: Available for Windows (x64/x86) and Linux (x64)

## Quick Start

1. Download the latest release for your platform from the [Releases](../../releases) page
2. Run the executable - no installation required!
3. The application will start monitoring and maintain activity when you're idle
4. Press `Ctrl+C` to stop the application

## How It Works

MouseJiggler monitors your system's idle time and simulates non-intrusive key presses when you've been inactive for more than 60 seconds. It uses:

- **Scroll Lock** toggle (primary method - completely invisible to applications)
- **Shift** key press (occasional, also non-intrusive)
- **Random timing** to make the activity appear natural

These key combinations are specifically chosen because they don't interfere with:
- Text input or editing
- Gaming
- Video playback
- Screen sharing or presentations

## System Requirements

- **Windows**: Windows 10/11 (x64 or x86)
- **Linux**: Modern Linux distribution (x64)
- **Memory**: ~10MB RAM
- **No .NET installation required** (self-contained executable)

## Build from Source

### Prerequisites
- .NET 9.0 SDK
- Git

### Building
```bash
git clone <repository-url>
cd MouseJiggler
dotnet build -c Release
```

### Publishing Self-Contained Executable
```bash
# Windows x64
dotnet publish -c Release -r win-x64 --self-contained true -p:PublishSingleFile=true

# Windows x86
dotnet publish -c Release -r win-x86 --self-contained true -p:PublishSingleFile=true

# Linux x64
dotnet publish -c Release -r linux-x64 --self-contained true -p:PublishSingleFile=true
```

## Release Process

This project uses automated GitHub Actions for releases. To create a new release:

### Using the Release Script (Recommended)
```powershell
# Create and push a new version tag
.\release.ps1 -Version "1.0.1"

# Dry run to see what would happen
.\release.ps1 -Version "1.0.1" -DryRun
```

### Manual Process
1. Update version in `MouseJiggler.csproj`
2. Commit changes: `git commit -am "Prepare release v1.0.1"`
3. Create tag: `git tag v1.0.1`
4. Push tag: `git push origin v1.0.1`
5. GitHub Actions will automatically build and create the release

### Manual Workflow Trigger
You can also trigger releases manually from the GitHub Actions tab using the "Build and Release" workflow.

## Configuration

Currently, the application uses these default settings:
- **Idle Threshold**: 60 seconds
- **Check Interval**: 15 seconds (±3 seconds random variation)
- **Key Press Duration**: 20-60ms random

To modify these settings, edit the values in `Program.cs` and rebuild.

## Troubleshooting

### Windows Security Warnings
Some antivirus software may flag the executable as suspicious due to its keyboard simulation functionality. This is a false positive - the application only simulates harmless key presses and doesn't access any sensitive data.

### Linux Permissions
On Linux, you may need to run with appropriate permissions to simulate key presses:
```bash
sudo ./MouseJiggler
```

### Application Not Working
1. Ensure you're running as administrator (Windows) or with sudo (Linux)
2. Check that no other application is blocking input simulation
3. Verify the console output shows the application is detecting idle time correctly

## Privacy & Security

- **No Network Access**: The application doesn't connect to the internet
- **No Data Collection**: No personal information is collected or stored
- **Local Only**: All operations are performed locally on your machine
- **Open Source**: Full source code is available for inspection

## Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit changes: `git commit -am "Add my feature"`
4. Push to branch: `git push origin feature/my-feature`
5. Create a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Disclaimer

This tool is designed for legitimate use cases such as preventing system sleep during downloads, presentations, or other activities. Please use responsibly and in accordance with your organization's policies.