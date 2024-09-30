func solution_18111() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, m, b) = (input[0], input[1], input[2])
    var graph = [[Int]]()
    for _ in 0 ..< n {
        let row = readLine()!.split(separator: " ").map { Int(String($0))! }
        graph.append(row)
    }
    
    var totalTime = Int.max
    var ans = 0
    
    for i in 0 ... 256 {
        var create = 0
        var delete = 0
        for x in 0 ..< n {
            for y in 0 ..< m {
                if graph[x][y] < i {
                    create += i - graph[x][y]
                    
                } else if graph[x][y] > i {
                    delete += graph[x][y] - i
                }
            }
        }
        
        if create > delete + b { continue }
        let time = create + delete * 2
        if time <= totalTime {
            ans = i
            totalTime = time
        }
    }
    print(totalTime, ans)
}
