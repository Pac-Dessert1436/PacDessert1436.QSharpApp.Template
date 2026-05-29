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

    function CountLiveNeighbors(grid : Bool[][], width : Int, height : Int, x : Int, y : Int) : Int {
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

    function NextGeneration(grid : Bool[][], width : Int, height : Int) : Bool[][] {
        mutable newGrid = [[], size = height];
        for row in 0..height-1 {
            mutable newRow = [false, size = width];
            for col in 0..width-1 {
                set newRow w/= col <- ComputeCell(
                    grid[row][col],
                    CountLiveNeighbors(grid, width, height, row, col)
                );
            }
            set newGrid w/= row <- newRow;
        }
        return newGrid;
    }

    operation GenerateRandomGrid(width : Int, height : Int) : Bool[][] {
        mutable grid = [[], size = height];
        for row in 0..height-1 {
            mutable newRow = [false, size = width];
            for col in 0..width-1 {
                set newRow w/= col <- QuantumRandomBit();
            }
            set grid w/= row <- newRow;
        }
        return grid;
    }

    function PrintGrid(grid : Bool[][], width : Int, height : Int) : Unit {
        for row in 0..height-1 {
            mutable line = "";
            for col in 0..width-1 {
                set line = line + (grid[row][col] ? "#" | ".");
            }
            Message(line);
        }
    }

    function RunGenerations(grid : Bool[][], width : Int, height : Int, maxGen : Int) : Unit {
        Message("Initial State:");
        PrintGrid(grid, width, height);

        mutable currentGrid = grid;
        for gen in 1..maxGen {
            set currentGrid = NextGeneration(currentGrid, width, height);
            Message($"\nGeneration {gen}:");
            PrintGrid(currentGrid, width, height);
        }
    }

    newtype GameOfLifeConfig = (Width : Int, Height : Int, Generations : Int);

    @EntryPoint()
    operation Main() : Unit {
        let cfg = GameOfLifeConfig(30, 10, 15);
        Message($"***** Quantum Game of Life: Q# Console App *****");
        Message($"Grid size: {cfg::Width}x{cfg::Height}, Generations: {cfg::Generations}\n");

        let grid = GenerateRandomGrid(cfg::Width, cfg::Height);
        RunGenerations(grid, cfg::Width, cfg::Height, cfg::Generations);

        Message("\n===== End of Simulation =====");
    }
}