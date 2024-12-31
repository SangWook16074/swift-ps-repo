func solution_2805() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (_, m) = (input[0], input[1])
    let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    var (start, end) = (0, arr.max()!)
    var ans = 0
    while start <= end {
        let mid = (start + end) / 2
        var total = 0
        for t in arr {
            if t > mid {
                total += t - mid
            }
        }
        if total >= m {
            ans = max(ans, mid)
            start = mid + 1
        } else {
            end = mid - 1
        }
    }
    print(ans)
}
