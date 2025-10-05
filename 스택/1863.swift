func solution_1863() {
    let n = Int(readLine()!)!
    var graph = [[Int]](), stk = [0], cnt = 0
    for _ in 0 ..< n {
        let xy = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
        let x = xy[0], y = xy[1]
        graph.append([x, y])
        
    }

    for i in 0 ..< n {
        let curr = graph[i]
        let y = curr[1]
        while let last = stk.last, last > y {
            stk.removeLast()
        }
        
        if let last = stk.last, last < y {
            cnt += 1
            stk.append(y)
        }
    }
    print(cnt)
}
