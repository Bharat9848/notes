

graph LR
    A[User Question] --> B[Query Enhancement]
    B --> C[Retrieve Documents]
    C --> D{Sufficient Info?}
    D -- No --> E[Refine Query]
    E --> C
    D -- Yes --> F[Generate Answer]
    F --> G{Answer Quality OK?}
    G -- No --> H{Try Different Approach?}
    H -- Yes --> E
    H -- No --> I[Return Best Answer]
    G -- Yes --> I
    I --> J[Return to User]

    classDef startend fill:#2e7d32,stroke:#1b5e20,stroke-width:2px,color:#fff
    classDef decision fill:#f9a825,stroke:#f57f17,stroke-width:2px,color:#000
    classDef process fill:#1976d2,stroke:#0d47a1,stroke-width:1.5px,color:#fff

    class A,J startend
    class B,C,E,F,I process
    class D,G,H decision