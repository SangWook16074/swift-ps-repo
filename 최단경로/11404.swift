import Foundation

func solution_11404() {
    let n = Int(readLine()!)!
    let m = Int(readLine()!)!
    let INF = 100_000 * (100 - 1) + 1
    var dist = [[Int]](repeating: [Int](repeating: INF, count: n + 1), count: n + 1)
    for _ in 0 ..< m {
        let input = readLine()!.split(separator: " ").map { Int(String($0))! }
        let a = input[0], b = input[1], c = input[2]
        dist[a][b] = min(dist[a][b], c)
    }

    for i in 1 ... n {
        dist[i][i] = 0
    }

    for k in 1 ... n {
        for i in 1 ... n {
            for j in 1 ... n {
                dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
            }
        }
    }

    for i in 1 ... n {
        for j in 1 ... n {
            print(dist[i][j] < INF ? dist[i][j] : 0, terminator: " ")
        }
        print()
    }

}
