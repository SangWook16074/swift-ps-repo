func solution_14719() {
    let hw = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
    let h = hw[0], w = hw[1]
    let graph = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
    var ans = 0
    for i in 0 ..< w {
        var left = 0, right = 0
        for j in 0 ..< i {
            left = max(left, graph[j])
        }
        
        for j in stride(from: w - 1, to: i, by: -1) {
            right = max(right, graph[j])
        }
        
        ans += max(0, min(left, right) - graph[i])
    }
    print(ans)
}
