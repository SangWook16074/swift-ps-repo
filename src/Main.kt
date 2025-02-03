fun main() {
    val heapq = Heapq<Long>()
}
class Heapq<T : Comparable<T>>(
    private val desc: Boolean? = false
){
    private val data = mutableListOf<T>()
    //최대 힙은 해당 부분의 정렬 기준을 부모 노드가 자식 노드보다 커야하기 때문에
    //조건을 a > b로 바꾸어 주면 됨.
    private val areSorted : (T, T) -> Boolean = {a, b ->
        if (this.desc!!) {
            a < b
        } else {
            a > b
        }
    }

    //size 메소드로 데이터 크기를 반환해야 함.
    val size : Int
        get() = data.size

    //peek() 메소드로 첫 번째 원소를 반환해야함 없으면 null 반환
    fun peek(): T? {
        return data.firstOrNull()
    }

    //enqueue() 메소드로 원소를 입력받음
    fun enqueue(element : T) : Unit{
        data.add(element)
        siftUp()
    }

    //siftUp() 메소드로 원소 재정렬을 수행함
    //siftUp() 메소드는 내부 데이터를 힙 자료에 맞게 재정렬을 함
    private fun siftUp() : Unit{
        var child : Int = data.size - 1
        var parent : Int = (child - 1) / 2
        while(child > 0 && areSorted(data[child], data[parent])){
            data.swap(child, parent)
            child = parent
            parent = (child - 1) / 2
        }
    }

    private fun MutableList<T>.swap(i : Int, j : Int){
        val tmp = this[i]
        this[i] = this[j]
        this[j] = tmp
    }

    //dequeue() 메소드를 통해서 루트 노드를 추출한다.
    //siftDown()을 수행한다.
    fun dequeue(element : T) : Boolean {
        //1. 삭제하려는 원소의 인덱스를 찾는다.
        val index = data.indexOf(element)
        if (index == -1){
            //삭제하려는 원소가 존재하지 않으면 false 를 반환
            return false
        }
        //2. 삭제하려는 원소를 마지막 원소와 교환한다.
        data.swap(index, data.size-1)
        //3. 마지막 원소 리스트에서 제거하여 현재 삭제하려는 원소를 추출한다.
        data.removeAt(data.size-1)

        //4. 삭제된 위치의 인덱스를 기준으로 힙을 재정렬한다.
        if(index < data.size){
            //자식 노드와 비교하여 정렬
            siftDown()
            //부모 노드와 비교하여 정렬
            siftUp()
        }
        return true
    }


    //siftDown() 메소드는 자료구조의 규칙에 맞게 다시 데이터를
    //재정렬한다.
    private fun siftDown() : Unit {
        //시작 노드는 부모 노드로
        var parent = 0
        while(true){
            //왼쪽 자식 노드의 인덱스
            val leftChild = parent * 2 + 1
            //오른쪽 자식 노드의 인덱스
            val rightChild = parent * 2 + 2
            //교환할 노드의 인덱스
            var change = parent

            //왼쪽 자식이 존재하고 왼쪽 자식이 부모보다 우선순위가 높으면 교환
            if (leftChild < data.size && areSorted(data[leftChild], data[change])) {
                change = leftChild
            }

            //오른쪽 자식이 존재하고 오른쪽 자식이 부모노드 우선순위보다 높으면 교환
            if (rightChild < data.size && areSorted(data[rightChild], data[change])) {
                change = rightChild
            }
            //부모 노드가 자식 노드보다 우선순위가 높으면 루프를 빠져나옴
            if(change == parent){
                break
            }
            //부모 노드와 교환 노드를 교환
            data.swap(parent, change)
            //교환할 자식을 새로운 부모로 설정
            parent = change
        }
    }


    //데이터 출력하기
    override fun toString(): String {
        return data.toString()
    }

}