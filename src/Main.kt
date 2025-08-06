fun requestSomething() {
    repository.requestA(
        onSuccess = {
            repository.requestB(
                onSuccess = {
                    repository.requestC(
                        onSuccess = {
                            // Do Next Thing
                        }
                    )
                }
            )
        }
    )
}

suspend fun requestSomethingUsingCoroutine() {
    val resultA = repository.requestA()
    val resultB = repository.requestB()
    val resultC = repository.requestC()
    // Do Next Thing
}