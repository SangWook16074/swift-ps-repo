func solution_2343() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (_, m) = (input[0], input[1])
    let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    var (start, end) = (arr.max()!, arr.reduce(0, +))
    var ans = end
    while start <= end {
        let mid = (start + end) / 2
        var cnt = 1
        var size = mid
        for l in arr {
            if size < l {
                cnt += 1
                size = mid
            }
            size -= l
        }
        if cnt <= m {
            ans = mid
            end = mid - 1
        } else {
            start = mid + 1
        }
    }
    print(ans)
}
