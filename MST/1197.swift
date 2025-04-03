func solution_1197() {
    
    typealias Node = (v: Int, e: Int, w: Int)

    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let v = input[0], e = input[1]
    var parent = Array(0 ... v)
    var graph = [Node]()
    var lines = 0
    var ans = 0

    func findParent(_ index : Int) -> Int {
        if parent[index] == index {
            return index
        } else {
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

    for _ in 0 ..< e {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let node = (input[0], input[1], input[2])
        graph.append(node)
    }

    graph = graph.sorted { $0.w < $1.w }

    for i in 0 ..< graph.count {
        if lines == v - 1 { break }
        let curr = graph[i]
        if findParent(curr.v) != findParent(curr.e) {
            ans += curr.w
            lines += 1
            unionParent(curr.v, curr.e)
        }
    }

    print(ans)

}
