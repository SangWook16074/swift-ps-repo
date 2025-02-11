func solution_12100() {
    let n = Int(readLine()!)!
    let graph = (1 ... n).map { _ in readLine()!.split(separator: " ").map { Int(String($0))! } }
    var ans = 0

    func moveToUp(_ board : [[Int]]) -> [[Int]] {
        var board = board
        for y in 0 ..< n {
            var line = (0 ..< n).map { board[$0][y] }
            line = line.filter { $0 != 0 }
            
            guard !line.isEmpty else { continue }
            
            for x in 0 ..< line.count - 1 {
                guard line[x] == line[x + 1] else {continue}
                line[x] *= 2
                line[x + 1] = 0
            }
            line = line.filter { $0 != 0 }
            while line.count < n { line.append(0) }
            (0 ..< n).forEach { board[$0][y] = line[$0] }
        }
        return board
    }
    func moveToDown(_ board : [[Int]]) -> [[Int]] {
        var board = board
        for y in 0 ..< n {
            var line = (0 ..< n).reversed().map { board[$0][y] }
            line = line.filter { $0 != 0 }
            
            guard !line.isEmpty else { continue }
            
            for x in 0 ..< line.count - 1 {
                guard line[x] == line[x + 1] else { continue }
                line[x] *= 2
                line[x + 1] = 0
            }
            
            line = line.filter { $0 != 0 }
            while line.count < n { line.append(0) }
            
            (0 ..< n).forEach { board[n - 1 - $0][y] = line[$0] }
        }
        return board
    }

    func moveToLeft(_ board : [[Int]]) -> [[Int]] {
        var board = board
        for x in 0 ..< n {
            var line = board[x]
            line = line.filter { $0 != 0 }
            
            guard !line.isEmpty else { continue }
            
            for y in 0 ..< line.count - 1 {
                guard line[y] == line[y + 1] else { continue }
                line[y] *= 2
                line[y + 1] = 0
            }
            
            line = line.filter { $0 != 0 }
            while line.count < n { line.append(0) }
            
            board[x] = line
        }
        return board
    }

    func moveToRight(_ board : [[Int]]) -> [[Int]] {
        var board = board
        for x in 0 ..< n {
            var line = Array(board[x].reversed())
            line = line.filter { $0 != 0 }
            
            guard !line.isEmpty else { continue }
            
            for y in 0 ..< line.count - 1 {
                guard line[y] == line[y + 1] else { continue }
                line[y] *= 2
                line[y + 1] = 0
            }
            
            line = line.filter { $0 != 0 }
            while line.count < n { line.append(0) }
            board[x] = line.reversed()
        }
        return board
    }

    func back(_ depth : Int, _ board : [[Int]]) {
        if depth == 5 {
            for x in 0 ..< n {
                for y in 0 ..< n {
                    ans = max(ans, board[x][y])
                }
            }
            return
        }
        for i in 0 ..< 4 {
            if i == 0 {
                back(depth + 1, moveToUp(board))
            } else if i == 1 {
                back(depth + 1, moveToDown(board))
            } else if i == 2 {
                back(depth + 1, moveToLeft(board))
            } else {
                back(depth + 1, moveToRight(board))
            }
        }
    }
    back(0, graph)
    print(ans)
}
