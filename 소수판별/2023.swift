import Foundation

func solution_2023() -> Void {
    let n = Int(readLine()!)!

    dfs(2, 1)
    dfs(3, 1)
    dfs(5, 1)
    dfs(7, 1)

    func dfs(_ num : Int, _ depth : Int) -> Void {
        if (n == depth) {
            if isPrime(num) {
                print(num)
                return
            }
        }
        
        for i in 1 ... 9 {
            if isPrime(num) {
                dfs(num * 10 + i, depth + 1)
            }
        }
    }

    func isPrime(_ num : Int) -> Bool {
        for i in 2 ..< Int(sqrt(Double(num))) + 1 {
            if num % i == 0 { return false }
        }
        return true
    }
}
