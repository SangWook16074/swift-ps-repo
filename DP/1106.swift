func solution_1106() {
    typealias City = (w: Int, v: Int)

    let cn = readLine()!.split(separator: " ").map { Int(String($0))! }
    let c = cn[0], n = cn[1]
    var cities = [City]()
    for _ in 0 ..< n {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let city = City(w: input[0], v: input[1])
        cities.append(city)
    }
    let INF = 1000 * 100 * 100 + 1
    var dp = Array(repeating: INF, count: c + 100)
    dp[0] = 0
    for (w, v) in cities {
        for i in v ..< c + 100 {
            dp[i] = min(dp[i], dp[i - v] + w)
        }
    }
    print(dp[c ..< c + 100].min()!)
}
