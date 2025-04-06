func solution_12920() {
    typealias Thing = (v: Int, w: Int)

    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0], m = input[1]

    var dp = [Int](repeating: 0, count: m + 1)
    var arr = [Thing]()

    for _ in 0 ..< n {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let v = input[0], c = input[1]
        var k = input[2]
        
        var i = 1
        while k > 0 {
            let a = min(i, k)
            arr.append((v: a * c, w : a * v))
            k -= i
            i *= 2
        }
    }

    for (v, w) in arr {
        for i in stride(from: m, through: w, by: -1) {
            dp[i] = max(dp[i], dp[i - w] + v)
        }
    }

    print(dp[m])
}
