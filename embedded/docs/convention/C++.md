# C++ Convention

## Format
Use clang-format (google style).

## Naming 
- Macro
    1. Use uppercase letters exclusively for macro names.
    2. Use underscores for spaces in macro names.
    ```
    #define MAX_SIZE 100
    #define ENABLE_FEATURE_X
    #define DEBUG_MODE_ENABLED
    ```

- Header Guard
    1. Include header guards in all header files without exception.  
    2. Formulate header guards using the file path to ensure uniqueness.
    ```
    // In "path/to/your/header/file.h"
    #ifndef PATH_TO_YOUR_HEADER_FILE_H_
    #define PATH_TO_YOUR_HEADER_FILE_H_

    // ... (contents of your header file)

    #endif // PATH_TO_YOUR_HEADER_FILE_H_
    ```

- Types
    Use CamelCase for naming types.
    ```
    class MyClass {
    public:
        using ValueType = int;
    // ...
    };
    ```

- Namespace
    1. Use 'prg' as the namespcae
    ```
    namespace prg {
    // Your code here
    }
    
    ``` 
    2. Avoid using 'using namespace std'

- Variable
    Use snake_case for variable names.
    ```
    int my_variable;
    double some_value;
    ```    

- Function
    Use snake_case for function names
    ```
    int calculate_sum(int a, int b) {
        return a + b;
    }

    void process_data(const std::vector<int>& data) {
        // Your code here
    }
    ``` 





