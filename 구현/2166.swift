import Foundation
func solution_2166() {
    typealias Pair = (x : Int, y : Int)

    let n = Int(readLine()!)!
    var arr = [Pair]()
    for _ in 0 ..< n {
        let row = readLine()!.split(separator: " ").map { Int(String($0))! }
        let x = row[0], y = row[1]
        arr.append((x, y))
    }
    arr.append(arr[0])
    var up = 0
    var down = 0
    for i in 0 ..< n {
        up += arr[i].x * arr[i + 1].y
        down += arr[i + 1].x * arr[i].y
    }
    let ans = Double(abs(up - down)) / 2
    print(String(format: "%.1f", ans))
}
