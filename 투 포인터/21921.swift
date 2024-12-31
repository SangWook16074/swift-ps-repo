func solution_21921() -> Void {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, x) = (input[0], input[1])
    let arr = readLine()!.split(separator: " ").map { Int(String($0))! }
    var total = 0
    for i in 0 ..< x {
        total += arr[i]
    }
    var ans = total
    var cnt = 1
    for i in x ..< n {
        total += arr[i] - arr[i - x]
        if total > ans {
            ans = total
            cnt = 1
        } else if total == ans {
            cnt += 1
        }
    }
    if ans == 0 {
        print("SAD")
    } else {
        print(ans)
        print(cnt)
    }

}
