func solution_9935() {
    let string = readLine()!
    let bomb = readLine()!
    let bombLast = bomb.last!
    let size = bomb.count
    var stk = [Character]()
    for char in string {
        stk.append(char)
        if char == bombLast && stk.count >= size && String(stk[stk.count - size ..< stk.count]) == bomb {
            stk.removeLast(size)
        }
    }
    print(stk.isEmpty ? "FRULA" : String(stk))
}
