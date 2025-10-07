import Foundation
func solution_14890() {
    let nl = readLine()!.split(separator: " ").compactMap { Int(String($0)) }
    let n = nl[0], l = nl[1]
    var rows = (0 ..< n).map { _ in readLine()!.split(separator: " ").compactMap { Int(String($0)) } }
    var cols = (0 ..< n).map { i in rows.map { $0[i] } }
    func find(_ line : [Int]) -> Bool {
        var visited = [Bool](repeating: false, count: n)
        for i in 1 ..< n {
            if abs(line[i] - line[i - 1]) > 1 { return false }
            if line[i - 1] > line[i] {
                for j in 0 ..< l {
                    if i + j >= n || line[i] != line[i + j] || visited[i + j] { return false }
                    if line[i] == line[i + j] { visited[i + j] = true }
                    
                }
            } else if line[i - 1] < line[i] {
                for j in 0 ..< l {
                    if i - j - 1 < 0 || line[i - 1] != line[i - j - 1] || visited[i - j - 1] { return false }
                    if line[i - 1] == line[i - j - 1] { visited[i - j - 1] = true }
                }
            }
            
        }
        return true
    }

    var ans = 0
    for i in 0 ..< n {
        if find(rows[i]) { ans += 1 }
        if find(cols[i]) { ans += 1 }
    }
    print(ans)
}
