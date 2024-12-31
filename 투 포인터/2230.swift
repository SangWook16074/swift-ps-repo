func solution_2230() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, m) = (input[0], input[1])
    var arr = [Int]()
    for _ in 0 ..< n {
        arr.append(Int(readLine()!)!)
    }
    arr = arr.sorted(by: <)
    var ans = arr.max()! - arr.min()!
    var (start, end) = (0, 0)
    while start < n - 1 {
        let dis = arr[end] - arr[start]
        if dis >= m {
            if dis < ans { ans = dis }
            start += 1
        } else {
            if end < n - 1 { end += 1 }
            else { start += 1 }
        }
    }
    print(ans)
}
