# PacDessert1436.QSharpApp.Template

A .NET template for creating Q# (QSharp) console applications, with **Quantum Game of Life** as an example implementation.

> **Important Note**: Please use version **1.0.3** or later because of several packaging issues on previous versions:
> - Version 1.0.0 incorrectly included LICENSE file and misplaced `.template.config` folder.
> - Version 1.0.1 was missing actual project content (Q# program and the project file).
> - Version 1.0.2 was missing the template configuration folder (`.template.config`).

## Features

- 🚀 Ready-to-use Q# console application template
- 🎮 Quantum Game of Life simulation using quantum randomness
- 📦 Pre-configured with Microsoft Quantum Development Kit
- ✨ Clean project structure with best practices

## Getting Started

### Prerequisites

- .NET 8 SDK or later
- Microsoft Quantum Development Kit (QDK)

### Installation

Install the template from NuGet:

```bash
dotnet new install PacDessert1436.QSharpApp.Template
```

Or install locally from source:

```bash
cd QSharpAppTemplate
dotnet new install .
```

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
├── AppMain.qs           # Main Q# program with Game of Life
└── MyQuantumApp.csproj  # Project configuration
```

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