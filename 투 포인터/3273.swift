func solution_3273() -> Void {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted(by: <)
    let x = Int(readLine()!)!
    var (start, end) = (0, n - 1)
    var ans = 0
    while start < end {
        let sum = arr[start] + arr[end]
        if sum == x { ans += 1 }
        if sum <= x { start += 1 }
        else { end -= 1 }
    }
    print(ans)
}
