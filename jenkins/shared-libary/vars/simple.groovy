// This is a simple example of a shared library

// This method is deprecated and should not be used
/*
* @deprecated Use 'simple2(String str)' method instead
*/
@Deprecated
def simple() {
    try {
        println "WARNING: The method is deprecated. Please use 'something(String str)' method instead."
        println "I said nothing"
    } catch (Exception e) {
        println "Error occurred: ${e.message}"
    }
}

def simple2(String str) {
    try {
        println "You've just said: ${str}!"
    } catch (Exception e) {
        println "Error occurred: ${e.message}"
    }
}