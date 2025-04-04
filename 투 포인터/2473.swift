func solution_2473() {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int(String($0))! }.sorted { $0 < $1 }
    var result = 3_000_000_001
    var ans = [Int]()
    for i in 0 ..< n - 2 {
        var start = i + 1, end = n - 1
        while start < end {
            let total = arr[i] + arr[start] + arr[end]
            if abs(total) < result {
                result = abs(total)
                ans = [arr[i], arr[start], arr[end]]
            }
            
            if total == 0 {
                break
            } else if total < 0 {
                start += 1
            } else {
                end -= 1
            }
        }
    }
    print(ans.map { String($0) }.joined(separator: " "))
}
