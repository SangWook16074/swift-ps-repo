import Foundation

func solution_2239() {
    typealias Pair = (x: Int, y : Int)

    var graph = (0 ..< 9).map { _ in readLine()!.map { Int(String($0))! } }
    var tmp = [Pair]()

    for x in 0 ..< 9 {
        for y in 0 ..< 9 {
            if graph[x][y] == 0 {
                tmp.append(Pair(x, y))
            }
        }
    }

    func rowCheck(_ num : Int, _ row : Int) -> Bool {
        for i in 0 ..< 9 {
            if graph[row][i] == num {
                return false
            }
        }
        return true
    }

    func colCheck(_ num : Int, _ col : Int) -> Bool {
        for i in 0 ..< 9 {
            if graph[i][col] == num {
                return false
            }
        }
        return true
    }

    func treeCheck(_ num : Int, _ row : Int, _ col : Int) -> Bool {
        let nx = (row / 3) * 3, ny = (col / 3) * 3
        for x in 0 ..< 3 {
            for y in 0 ..< 3 {
                if graph[nx + x][ny + y] == num {
                    return false
                }
            }
        }
        
        return true
    }

    func dfs(_ depth: Int) {
        if depth >= tmp.count {
            for x in 0 ..< 9 {
                print(graph[x].map { String($0) }.joined(separator: ""))
            }
            exit(0)
        }
        let curr = tmp[depth]
        let row = curr.x, col = curr.y
        print(depth)
        for i in 1 ... 9 {
            if rowCheck(i, row) && colCheck(i, col) && treeCheck(i, row, col) {
                graph[row][col] = i
                dfs(depth + 1)
                graph[row][col] = 0
            }
        }
    }
    dfs(0)
}
