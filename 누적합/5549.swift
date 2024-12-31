func solution_5549() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, m) = (input[0], input[1])
    let k = Int(readLine()!)!
    var graph = [[String]]()
    for _ in 0 ..< n {
        graph.append(readLine()!.map { String($0) })
    }
    var pSum = Array(repeating: Array(repeating: Array(repeating: 0, count: 3), count: m + 1), count: n + 1)
    for x in 1 ... n {
        for y in 1 ... m {
            for z in 0 ..< 3 {
                pSum[x][y][z] = pSum[x - 1][y][z] + pSum[x][y - 1][z] - pSum[x - 1][y - 1][z]
            }
            if graph[x - 1][y - 1] == "J" { pSum[x][y][0] += 1 }
            else if graph[x - 1][y - 1] == "O" { pSum[x][y][1] += 1 }
            else if graph[x - 1][y - 1] == "I" { pSum[x][y][2] += 1 }
        }
    }

    for _ in 0 ..< k {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let (x1, y1, x2, y2) = (input[0], input[1], input[2], input[3])
        var ans = ""
        for z in 0 ..< 3 {
            ans += "\(pSum[x2][y2][z] - pSum[x1 - 1][y2][z] - pSum[x2][y1 - 1][z] + pSum[x1 - 1][y1 - 1][z]) "
        }
        print(ans)
    }
}
