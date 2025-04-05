func solution_1922() {
    typealias Edge = (u: Int, v: Int, w: Int)

    let n = Int(readLine()!)!
    let m = Int(readLine()!)!
    var parent = Array(0 ... n)
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

    var graph = [Edge]()
    for _ in 0 ..< m {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let u = input[0], v = input[1], w = input[2]
        let edge = (u: u, v: v, w: w)
        graph.append(edge)
    }

    graph = graph.sorted { $0.w < $1.w }
    var ans = 0
    for edge in graph {
        let u = edge.u, v = edge.v, w = edge.w
        if findParent(u) != findParent(v) {
            unionParent(u, v)
            ans += w
        }
    }
    print(ans)
}
