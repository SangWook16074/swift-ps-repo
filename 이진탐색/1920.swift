func solution_1920() -> Void {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted(by: <)
    let _ = Int(readLine()!)!
    let targets = readLine()!.split(separator: " ").map { Int(String($0))! }
    for t in targets {
        var ans = 0
        var (start, end) = (0, n-1)
        while start <= end {
            let mid = (start + end) / 2
            if arr[mid] == t {
                ans = 1
                break
            } else if arr[mid] < t {
                start = mid + 1
            } else if arr[mid] > t {
                end = mid - 1
            }
        }
        print(ans)
    }
}
