import java.io.StreamTokenizer
import kotlin.math.abs

fun main() = with(StreamTokenizer(System.`in`.bufferedReader())) {
    fun nextInt() : Int { nextToken(); return nval.toInt() }
    val n = nextInt()
    var ans = 0
    val cols = IntArray(n) {0}
    fun check(row : Int) : Boolean {
        for (before in 0 ..< row) {
            if (
                (cols[before] == cols[row])
                ||
                (abs(cols[before] - cols[row]) == abs(before - row))
                )
            {
                return false
            }
        }
        return true
    }
    fun dfs(row : Int) {
        if (row == n) { ans ++; return }
        for (i in 0 ..< n ) {
            cols[row] = i
            if (check(row)) {
                dfs(row + 1)
            }
        }
    }
    dfs(0)
    print(ans)
}