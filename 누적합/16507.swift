func solution_16507() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (r, c, q) = (input[0], input[1], input[2])
    var graph = [[Int]]()
    for _ in 0 ..< r {
        let row = readLine()!.split(separator: " ").map { Int(String($0))! }
        graph.append(row)
    }
    var pSum = Array(repeating: Array(repeating: 0, count: c + 1), count: r + 1)
    for x in 1 ... r {
        for y in 1 ... c {
            pSum[x][y] = pSum[x - 1][y] + pSum[x][y - 1] + graph[x - 1][y - 1] - pSum[x - 1][y - 1]
        }
    }
    for _ in 0 ..< q {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let (r1, c1, r2, c2) = (input[0], input[1], input[2], input[3])
        let div = (r2 - r1 + 1) * (c2 - c1 + 1)
        let sum = pSum[r2][c2] - pSum[r2][c1 - 1] - pSum[r1 - 1][c2] + pSum[r1 - 1][c1 - 1]
        print(sum / div)
    }
}
