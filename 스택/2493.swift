func solution_2943() {
    struct Top {
        let idx : Int
        let height: Int
        
        init(idx: Int, height: Int) {
            self.idx = idx
            self.height = height
        }
    }

    let n = Int(readLine()!)!
    let input = readLine()!.split(separator: " ").map { Int(String($0))! }
    let arr = (0 ..< n).reversed().map { Top(idx: $0, height: input[$0]) }
    var ans = [Int](repeating: 0, count: n)
    var stk = [Top]()
    for i in 0 ..< n {
        while !stk.isEmpty && stk.last!.height <= arr[i].height {
            let t = stk.popLast()!
            ans[t.idx] = arr[i].idx + 1
        }
        stk.append(arr[i])
    }
    ans.forEach { print($0, terminator: " ") }
}
