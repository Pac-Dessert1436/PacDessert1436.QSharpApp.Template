# PacDessert1436.QSharpApp.Template

A .NET template for creating Q# (QSharp) console applications, with **Quantum Game of Life** as an example implementation.

> **Note on Latest Version**: _Version **1.0.15** is the latest production-ready release._ Building on the stable foundation of 1.0.14, this release features a simplified Q# codebase without recursive functions, making it cleaner, more maintainable, and easier to understand.

## Features

- 🚀 **Ready-to-use** Q# console application template
- 🎮 Quantum Game of Life simulation using quantum randomness
- 📦 Pre-configured with Microsoft Quantum Development Kit
- ✨ Clean project structure with best practices
- 📝 Complete C# project configuration with all necessary settings

## Version Notes: 1.0.14 → 1.0.15

- **Simplified Q# Codebase**: Removed recursive functions from the Quantum Game of Life implementation
- **Improved Readability**: Flattened control flow makes the code easier to understand and maintain
- **Performance Optimizations**: Iterative approach provides better execution characteristics
- **No Breaking Changes**: API and usage remain fully compatible with version 1.0.14

## Getting Started

### Prerequisites

- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0) or later
- Microsoft Quantum Development Kit (QDK)

### Installation

Install the template from NuGet via the following command (note that `@` is now the recommended way to specify the version number, since `::` was deprecated):

```bash
dotnet new install PacDessert1436.QSharpApp.Template@1.0.15
```

... or install the latest version without specifying the version number.

### Create a New Project

Use the template to create a new Q# console application:

```bash
dotnet new qsharpapp -n MyQuantumApp
cd MyQuantumApp
```

### Run the Application

```bash
dotnet run
```

## Template Structure

```
MyQuantumApp/
├── AppMain.qs           # Main Q# program with Game of Life implementation
└── MyQuantumApp.csproj  # C# project configuration file
```

## C# Project Configuration

The generated `MyQuantumApp.csproj` includes the following key configurations:

### SDK and Framework
- **SDK**: Microsoft.Quantum.Sdk (version 0.28.302812)
- **Target Framework**: .NET 8.0
- **Output Type**: Console Application (Exe)

### Project Properties
- **Root Namespace**: Set to project name (e.g., `MyQuantumApp`)
- **Implicit Usings**: Enabled
- **Nullable Reference Types**: Enabled

### Template Metadata (for package generation)
- **PackageId**: `PacDessert1436.QSharpApp.Template`
- **Version**: 1.0.15
- **Title**: Q# Console App Template
- **Authors**: Pac-Dessert1436
- **PackageType**: Template

## Quantum Game of Life

This template implements Conway's Game of Life using **quantum randomness** for initial grid generation. Each cell's initial state is determined by measuring a qubit in superposition, creating a truly random starting configuration.

### Key Q# Operations

- `QuantumRandomBit()` - Generates a random bit using quantum superposition
- `GenerateRandomGrid()` - Creates a grid with quantum-random initial states
- `NextGeneration()` - Computes the next generation using Game of Life rules
- `PrintGrid()` - Displays the grid in the console

### Configuration

Modify the `Main()` operation in `AppMain.qs` to customize:

```qsharp
let cfg = GameOfLifeConfig(Width, Height, Generations);
```

- **Width**: Number of columns in the grid (default: 30)
- **Height**: Number of rows in the grid (default: 10)
- **Generations**: Number of simulation steps (default: 15)

## Game of Life Rules

The simulation follows Conway's classic rules:

1. **Alive cell** (`#` symbol) survives if it has 2 or 3 live neighbors
2. **Dead cell** (`.` symbol) becomes alive if it has exactly 3 live neighbors
3. All other cells die or remain dead

## Development

### Build the Template

```bash
cd QSharpAppTemplate
dotnet pack
```

### Test the Template

```bash
dotnet new qsharpapp -o TestApp
cd TestApp
dotnet run
```

## License

This project is licensed under the BSD 3-Clause License. See the [LICENSE](LICENSE) file for details.

## Resources

- [Q# Documentation](https://learn.microsoft.com/en-us/azure/quantum/)
- [Microsoft Quantum Development Kit](https://aka.ms/qdk)
- [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life)

## Version History

- **⚠️ 1.0.0-1.0.13 Deprecated**: Various packaging and configuration issues including:
    - Incorrect packaging metadata in `.nuspec` file or `.csproj` file
    - Missing essential files for the template (`AppMain.qs`, `.csproj`)
    - Unexpected NuGet artifacts exposing the author's personal information

- **✅ 1.0.14 Stable**: Fixed packaging metadata moved to `.nuspec` file. Essential files for Q# console applications now correctly packaged.

- **✅ 1.0.15 Enhanced**: Simplified Q# codebase with iterative approach (no recursive functions). Improved readability and maintainability while maintaining full backward compatibility.