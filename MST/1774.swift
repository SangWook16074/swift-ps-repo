import Foundation

func solution_1774() {
    
    
    typealias Pos = (x: Int, y: Int)
    typealias Edge = (u: Int, v: Int, w: Double)

    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let n = input[0], m = input[1]
    var parents = Array(0 ... n)

    func findParent(_ index : Int) -> Int {
        if parents[index] == index { return index }
        else {
            parents[index] = findParent(parents[index])
            return parents[index]
        }
    }

    func unionParent(_ a : Int, _ b : Int) {
        let num1 = findParent(a)
        let num2 = findParent(b)
        if a < b {
            parents[num2] = num1
        } else {
            parents[num1] = num2
        }
    }

    func getDistance(_ a : Pos, _ b : Pos) -> Double {
        let dx = a.x - b.x
        let dy = a.y - b.y
        return sqrt(Double(dx * dx + dy * dy))
    }

    var poss = [Pos]()
    for _ in 0 ..< n {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let x = input[0], y = input[1]
        let pos = (x: x, y: y)
        poss.append(pos)
    }

    for _ in 0 ..< m {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let a = input[0], b = input[1]
        unionParent(a - 1, b - 1)
    }
    var graph = [Edge]()
    for i in 0 ..< n - 1 {
        for j in i + 1 ..< n {
            let a = poss[i], b = poss[j]
            let dist = getDistance(a, b)
            let edge = (u: i, v: j, w: dist)
            graph.append(edge)
        }
    }
    graph = graph.sorted { $0.w < $1.w }
    var ans : Double = 0
    for edge in graph {
        let u = edge.u, v = edge.v, w = edge.w
        if findParent(u) != findParent(v) {
            ans += w
            unionParent(u, v)
        }
    }
    print(String(format: "%.2f", ans))

}
