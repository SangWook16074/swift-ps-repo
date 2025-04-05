import Foundation

func solution_2887() {

    typealias Planet = (i: Int, x: Int, y: Int, z: Int)
    typealias Edge = (u: Int, v: Int, w: Int)

    let n = Int(readLine()!)!
    var parent = Array(0 ... n)

    var planets = [Planet]()
    var graph = [Edge]()
    for i in 0 ..< n {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let x = input[0], y = input[1], z = input[2]
        let planet = (i: i, x: x, y: y, z: z)
        planets.append(planet)
    }

    planets = planets.sorted { $0.x < $1.x }
    for i in 0 ..< n - 1 {
        let curr = planets[i], next = planets[i + 1]
        graph.append((curr.i, next.i, abs(curr.x - next.x)))
    }

    planets = planets.sorted { $0.y < $1.y }
    for i in 0 ..< n - 1 {
        let curr = planets[i], next = planets[i + 1]
        graph.append((curr.i, next.i, abs(curr.y - next.y)))
    }

    planets = planets.sorted { $0.z < $1.z }
    for i in 0 ..< n - 1 {
        let curr = planets[i], next = planets[i + 1]
        graph.append((curr.i, next.i, abs(curr.z - next.z)))
    }

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

    graph = graph.sorted { $0.w < $1.w }
    var line = 0
    var ans = 0
    for edge in graph {
        let u = edge.u, v = edge.v, w = edge.w
        if line == n - 1 { break }
        if findParent(u) != findParent(v) {
            unionParent(u, v)
            line += 1
            ans += w
        }
    }
    print(ans)
}
