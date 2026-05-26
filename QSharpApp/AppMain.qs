namespace AppMain {
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Measurement;
    open Microsoft.Quantum.Convert;

    operation QuantumRandomBit() : Bool {
        use qubit = Qubit();
        H(qubit);
        let result = M(qubit);
        Reset(qubit);
        return result == One;
    }

    operation PrintGrid(grid : Bool[][], width : Int, height : Int) : Unit {
        PrintGridHelper(grid, width, height, height);
    }

    operation PrintGridHelper(grid : Bool[][], width : Int, height : Int, rowIdx : Int) : Unit {
        if rowIdx > 0 {
            let row = rowIdx - 1;
            PrintGridHelper(grid, width, height, rowIdx - 1);
            Message(RowToString(grid[row], width));
        }
    }

    function RowToString(row : Bool[], width : Int) : String {
        return RowToStringHelper(row, width, "");
    }

    function RowToStringHelper(row : Bool[], width : Int, acc : String) : String {
        if width == 0 { return acc; }
        return RowToStringHelper(row, width - 1, acc + (row[width - 1] ? "#" | "."));
    }

    operation ComputeRow(grid : Bool[][], width : Int, height : Int, row : Int) : Bool[] {
        return ComputeRowHelper(grid, width, height, row, width);
    }

    operation ComputeRowHelper(
        grid : Bool[][],
        width : Int,
        height : Int,
        row : Int,
        colIdx : Int
    ) : Bool[] {
        if colIdx == 0 { return []; }
        let col = colIdx - 1;
        let neighbors = CountLiveNeighbors(grid, width, height, row, col);
        let cellValue = ComputeCell(grid[row][col], neighbors);
        let rest = ComputeRowHelper(grid, width, height, row, colIdx - 1);
        return [cellValue] + rest;
    }

    operation NextGeneration(grid : Bool[][], width : Int, height : Int) : Bool[][] {
        return NextGenerationHelper(grid, width, height, height);
    }

    operation NextGenerationHelper(
        grid : Bool[][],
        width : Int,
        height : Int,
        rowIdx : Int
    ) : Bool[][] {
        if rowIdx == 0 { return []; }
        let row = rowIdx - 1;
        let newRow = ComputeRow(grid, width, height, row);
        let rest = NextGenerationHelper(grid, width, height, rowIdx - 1);
        return [newRow] + rest;
    }

    operation GenerateRandomGrid(width : Int, remaining : Int) : Bool[][] {
        if remaining == 0 { return []; }
        let row = GenerateRandomRow(width, width);
        let rest = GenerateRandomGrid(width, remaining - 1);
        return [row] + rest;
    }

    operation GenerateRandomRow(width : Int, remaining : Int) : Bool[] {
        if remaining == 0 { return []; }
        let bit = QuantumRandomBit();
        let rest = GenerateRandomRow(width, remaining - 1);
        return [bit] + rest;
    }

    function CountLiveNeighbors(
        grid : Bool[][],
        width : Int,
        height : Int,
        x : Int,
        y : Int
    ) : Int {
        mutable count = 0;
        for dx in -1..1 {
            for dy in -1..1 {
                if not (dx == 0 and dy == 0) {
                    let nx = (x + dx + height) % height;
                    let ny = (y + dy + width) % width;
                    if grid[nx][ny] {
                        set count = count + 1;
                    }
                }
            }
        }
        return count;
    }

    function ComputeCell(isAlive : Bool, neighbors : Int) : Bool {
        if isAlive {
            return neighbors == 2 or neighbors == 3;
        } else {
            return neighbors == 3;
        }
    }

    operation RunGenerations(
        grid : Bool[][],
        width : Int,
        height : Int,
        maxGen : Int,
        currGen : Int
    ) : Unit {
        if currGen < maxGen {
            let newGrid = NextGeneration(grid, width, height);
            Message($"\nGeneration {currGen + 1}:");
            PrintGrid(newGrid, width, height);
            RunGenerations(newGrid, width, height, maxGen, currGen + 1);
        }
    }

    newtype GameOfLifeConfig = (Width : Int, Height : Int, Generations : Int);

    @EntryPoint()
    operation Main() : Unit {
        let cfg = GameOfLifeConfig(30, 10, 15);
        Message($"***** Quantum Game of Life: Q# Console App *****");
        Message($"Grid size: {cfg::Width}x{cfg::Height}, Generations: {cfg::Generations}\n");
        let grid = GenerateRandomGrid(cfg::Width, cfg::Height);
        Message("Initial State:");
        PrintGrid(grid, cfg::Width, cfg::Height);
        RunGenerations(grid, cfg::Width, cfg::Height, cfg::Generations, 0);
        Message("\n===== End of Simulation =====");
    }
}