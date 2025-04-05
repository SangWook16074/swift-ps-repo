import Foundation

func solution_4386() {
    
    typealias Point = (i: Int, x: Double, y: Double)
    typealias Edge = (u: Int, v: Int, w: Double)

    let n = Int(readLine()!)!
    var parent = Array(0 ... n)
    var points = [Point]()
    for i in 1 ... n {
        let input = readLine()!.split(separator: " ").map { Double(String($0))! }
        let x = input[0], y = input[1]
        let point = (i: i, x: x, y: y)
        points.append(point)
    }
    var graph = [Edge]()
    for i in 0 ..< n {
        for j in 0 ..< n {
            if i == j { continue }
            let u = i, v = j
            let dx = abs(points[i].x - points[j].x)
            let dy = abs(points[i].y - points[j].y)
            let distance = sqrt(dx * dx + dy * dy)
            graph.append((u: i, v: j, w: distance))
        }
    }

    graph = graph.sorted { $0.w < $1.w }

    func findParent(_ index : Int) -> Int {
        if parent[index] == index { return index }
        else {
            parent[index] = findParent(parent[index])
            return parent[index]
        }
    }

    func unionParent(_ a : Int, _ b : Int) {
        let num1 = findParent(a)
        let num2 = findParent(b)
        if a < b {
            parent[num2] = num1
        } else {
            parent[num1] = num2
        }
    }

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
