//data class
//사용자 값을 하나의 객체로 묶기 위해서
data class CommandInput(val command: String, val value: Int)

var result = 0
const val LIMIT = 1_000_000_000

fun main() {
    while (true) {
        val input = input() ?: continue
        val (command, value) = input

        if (command == "CLOSE") {
            if (value == 0) break
            println("CLOSE만 들어올 수 있습니다.")
            continue
        }

        if (command == "DIV" && value == 0) {
            println("0으로 나눌 수 없습니다.")
            continue
        }

        calculate(command, value)
    }

    println(display(result))
}

fun input(): CommandInput? {
    val br = System.`in`.bufferedReader()
    val line = br.readLine() ?: return null
    val parts = line.split(" ")

    if (parts.size != 2) {
        if (line == "CLOSE") return CommandInput("CLOSE", 0)
        return null
    }

    val command = parts[0]
    val value = parts[1].toIntOrNull()

    if (value == null) {
        println("숫자를 올바르게 입력하세요.")
        return null
    }

    return CommandInput(command, value)
}

fun calculate(command: String, value: Int) {
    val next = when (command) {
        "ADD" -> result + value
        "MINUS" -> result - value
        "MUL" -> result * value
        "DIV" -> result / value
        else -> result
    }

    if (next >= LIMIT) {
        println("결과값은 10억을 초과할 수 없습니다.")
        return
    }

    result = next
}

fun display(value: Int): String = when {
    value > 0 -> "+$value"
    value == 0 -> "0"
    else -> "-${-value}"
}