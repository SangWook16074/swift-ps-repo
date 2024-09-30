func solution_17413() -> Void {
    let s = readLine()!
    var isTag = false
    var words = [Character]()
    for c in s {
        if c == "<" {
            while !words.isEmpty {
                print(words.popLast()!, terminator: "")
            }
            isTag = true
        }
        
        if c == ">" {
            print(c, terminator: "")
            isTag = false
            continue
        }
        
        if isTag {
            print(c, terminator:"")
            continue
        } else {
            if c == " " {
                while !words.isEmpty {
                    print(words.popLast()!, terminator: "")
                }
                print(" ", terminator: "")
            } else {
                words.append(c)
            }
        }
        
        
    }
    
    while !words.isEmpty {
        print(words.popLast()!, terminator: "")
    }
}
