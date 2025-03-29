func solution_15684() {
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0], m = input[1], k = input[2]
    var arr = [[Int]](repeating: [Int](repeating: 0, count: n), count: k)
    for _ in 0 ..< m {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let a = input[0], b = input[1]
        arr[a - 1][b - 1] = 1
    }
    func check() -> Bool {
        for i in 0 ..< n {
            var start = i
            for j in 0 ..< k {
                if arr[j][start] == 1 {
                    start += 1
                } else if start > 0 && arr[j][start - 1] == 1 {
                    start -= 1
                }
            }
            if start != i { return false }
        }
        return true
    }
    var ans = 4
    func dfs(_ cnt : Int, _ x : Int, _ y : Int) {
        if ans < cnt { return }
        if check() {
            ans = min(ans, cnt)
            return
        }
        if cnt == 3 { return }
        for i in 0 ..< n - 1 {
            for j in y ..< k {
                if arr[j][i] == 0 {
                    arr[j][i] = 1
                    dfs(cnt + 1, i + 2, j)
                    arr[j][i] = 0
                }
            }
        }
    }
    dfs(0, 0, 0)
    print(ans > 3 ? -1 : ans)
}
