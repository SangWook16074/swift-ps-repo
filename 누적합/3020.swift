func solution_3020() {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let (n, h) = (input[0], input[1])
    var line = Array(repeating: 0, count: h)
    for i in 0 ..< n {
        let s = Int(readLine()!)!
        if (i % 2 == 0) {
            line[h - s] += 1
        } else {
            line[0] += 1
            line[s] -= 1
        }
    }
    for i in 1 ..< h {
        line[i] += line[i - 1]
    }
    let ans = line.min()!
    var cnt = 0
    line.forEach { l in
        if (l == ans) { cnt += 1 }
    }
    print(ans, cnt)
}
