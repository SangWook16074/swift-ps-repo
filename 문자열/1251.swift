func solution_1251() {
    let word = Array(readLine()!).map { String($0) }
    var results = [String]()

    func arrayReversedAndToString(_ str : Array<String>.SubSequence) -> String {
        return String(str.joined().reversed())
    }

    for i in 0 ..< word.count - 2 {
        for j in i + 1 ..< word.count - 1 {
            let first = arrayReversedAndToString(word[0 ... i])
            let second = arrayReversedAndToString(word[i + 1 ... j])
            let last = arrayReversedAndToString(word[j + 1 ... word.count - 1])
            let result = first + second + last
            results.append(result)
        }
    }
    print(results.sorted().first!)
}
