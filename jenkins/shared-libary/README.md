#Jenkins Shared Libary
## 1. Define the Libary
- Repository structure
```
(root)
├── vars/
│   └── example.groovy
├── src/
│   └── org/
│       └── foo/
│           └── Bar.groovy
└── resources/
    └── org/
        └── foo/
            └── bar.txt
```

## 2. Configure Jenkins
- Go to Jenkins Dashboard > Manage Jenkins > Configure System
- In the "Global Pipeline Libaries" section, add new libary:
  - **Name**: Name of the libary
  - **Default version**: Recommend leave it blank to force use version
  - **Retrieval method**: Default choose `Modern SCM`
  - **Source Code Management**: Default choose `Git` with repository URL and Credential

## 3. Versionsing Libary
### 3.1 Semantic Versionsing:
Follow Semantic Versioning (SemVer) principles:
`MAJOR.MINOR.PATCH`
- **MAJOR**: Incompatible changes
- **MINIOR**: Backward-compatible functionality
- **PATCH**: Backward-compatible bug fixes

### 3.2 Tagging Releases:
