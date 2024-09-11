# Jenkins pipelines

## 1. Using Shared Libary
### 1.1 Load the Shared Libary:
- In Jenkins pipeline script, load shared libary using `@Libary` annotation:
  
  ```groovy
  @Libary('shared-lib-name@version') _
  ```
    > **The version of shared lib should be specific**

- Call functions from the shared libary:
  Use the function defined in shared libary in pipeline 
    
    ```groovy
    @Libary('shared-lib-name@version') _

    example()
    ```