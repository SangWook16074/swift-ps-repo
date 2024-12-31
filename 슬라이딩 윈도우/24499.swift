func solution_24499() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, k) = (input[0], input[1])
    let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    var sum = 0
    var ans = 0
    for i in 0 ..< k {
        sum += arr[i]
    }
    ans = sum
    for i in 1 ..< n {
        sum += arr[(i + k - 1) % n] - arr[i - 1]
        ans = max(ans, sum)
    }
    print(ans)
}
