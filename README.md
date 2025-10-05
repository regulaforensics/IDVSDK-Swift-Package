# IDV SDK Integration Guide

## Introduction

This guide provides step-by-step instructions on integrating the **IDV SDK** into an iOS application. 
It covers initialization, API configuration, workflow setup, and starting the ID verification process.

---

## Prerequisites

Before integrating the SDK, ensure the following:

- The application Minimum Deployment Target is **iOS 14** and above
- The SDK includes multiple modules (e.g., for liveness, face matching, document reader). Depending on your use case, you may need to include additional pods or follow the module-specific setup instructions from the documentation. Always check which modules are required for your workflow.
---

## Installation

### Cocoapods

Add the base dependency into your Podfile:

```
target 'YourAppTarget' do
  use_frameworks!
  
  pod 'IDVSDK'
end
```

Then install it:

```
pod install
```


#### Optional Modules

##### 1. Document Reader module

[Document Reader module installation guide](https://github.com/regulaforensics/IDVDocumentReader-Swift-Package/blob/main/README.md)

##### 2. Face SDK module

[Face SDK module installation guide](https://github.com/regulaforensics/IDVFaceSDK-Swift-Package/blob/main/README.md)

### Swift Package Manager (SPM)

#### Swift Package Collection

Swift Package Collection is a set of all Regula products in one place.

To add Regula Swift Package Collection to your project, run the following command in Terminal:

```
swift package-collection add https://pods-master.regulaforensics.com/SPM/PodsCollection-signed.json
```

or in Xcode:

1. Navigate to File > Add Package Dependencies.

2. In the prompt that appears, click plus.

3. Select Add Package Collection.

4. In the prompt that appears, enter the collection URL:

```
https://pods.regulaforensics.com/SPM/PodsCollection-signed.json
```

5. Click Load and then Add Collection.

6. Select the package you want to add.

7. Select the version you want to use. For new projects, we recommend using the newest version.

8. Select the project you want to add the package.

9. Click Add Package.

Once you're finished, Xcode will begin downloading and resolving dependencies.

#### Add Packages Separately

You can add each package individually instead of using the collection. To do so, follow these steps:

1. In Xcode, naviate to File > Add Package Dependencies.

2. In the prompt that appears, enter the API package URL:

```
https://github.com/regulaforensics/IDVSDK-Swift-Package
```

3. Select the version you want to use. For new projects, we recommend using the newest version.

4. Select the project you want to add the package.

5. Click Add Package.

6. **If you need IDVDocumentReader module -** [Document Reader module installation guide](https://github.com/regulaforensics/IDVDocumentReader-Swift-Package/blob/main/README.md)

7. **If you need IDVFaceSDK module -** [Face SDK module installation guide](https://github.com/regulaforensics/IDVFaceSDK-Swift-Package/blob/main/README.md)

Once you're finished, Xcode will begin downloading and resolving dependencies.

---

## Initialize Regula IDV SDK

Initialize the SDK:

```swift
import IDVSDK

IDV.shared.initialize { result in
    switch result {
    case .success:
        print("IDV SDK initialized successfully")
    case .failure(let error):
        print("Initialization failed: \(error)")
    }
}
```

---

## Configure API Settings

Before using the SDK, configure the API connection using one of the following methods:


### 1. Username & Password
```swift
let connectionConfig = CredentialsConnectionConfig(
    host: "your_host",
    username: "your_username",
    password: "your_password"
)

IDV.shared.configure(with: connectionConfig) { result in
    switch result {
    case .success:
        print("Configured successfully")
    case .failure(let error):
        print("Configuration failed: \(error)")
    }
}
```


### 2. Token-based
```swift
let tokenConfig = TokenConnectionConfig(url: URL(string: "your_token_url")!)

IDV.shared.configure(with: tokenConfig) { result in
    switch result {
    case .success(let workflowIds):
        print("Available workflows: \(workflowIds)")
    case .failure(let error):
        print("Configuration failed: \(error)")
    }
}
```


### 3. API Key
```swift
let apiKeyConfig = ApiKeyConnectionConfig(apiKey: "your_api_key")

IDV.shared.configure(with: apiKeyConfig) { result in
    switch result {
    case .success:
        print("Configured successfully with API key")
    case .failure(let error):
        print("Configuration failed: \(error)")
    }
}
```

---

## Retrieve, Prepare and Start Verification Workflow


### Retrieve Available Workflows

```swift
IDV.shared.getWorkflows { result in
    switch result {
    case .success(let workflows):
        print("Available workflows: \(workflows)")
    case .failure(let error):
        print("Failed to fetch workflows: \(error)")
    }
}
```

### Prepare a Workflow

```swift
let workflowConfig = PrepareWorkflowConfig(workflowId: "your_workflow_id")

IDV.shared.prepareWorkflow(by: workflowConfig) { result in
    switch result {
    case .success(let workflow):
        print("Workflow prepared: \(workflow.id)")
    case .failure(let error):
        print("Failed to prepare workflow: \(error)")
    }
}
```

### Start Workflow

```swift
IDV.shared.startWorkflow(presenter: presenterViewController) { result in
    switch result {
    case .success(let workflowResult):
        print("Verification finished. Session ID: \(workflowResult.sessionId)")
    case .failure(let error):
        print("Verification failed: \(error)")
    }
}
```

Optionally, you can pass a StartWorkflowConfig with metadata:: 

```swift
var config = StartWorkflowConfig.default()
config.metadata = ["key": "value"]

IDV.shared.startWorkflow(presenter: self, config: config) { result in
    switch result {
    case .success(let workflowResult):
        print("Workflow completed successfully")
    case .failure(let error):
        print("Workflow failed: \(error)")
    }
}
```

To start workflow with locale language:

```swift
var config = StartWorkflowConfig.default()
config.locale = "en"
IDV.shared.startWorkflow(presenter: self, config: config) { result in
    switch result {
    case .success(let workflowResult):
        print("Workflow completed successfully")
    case .failure(let error):
        print("Workflow failed: \(error)")
    }
}
```

---

## Deinitialize SDK

When the SDK is no longer needed (e.g., logout):

```swift
IDV.shared.deinitialize { result in
    switch result {
    case .success:
        print("SDK deinitialized")
    case .failure(let error):
        print("Failed to deinitialize: \(error)")
    }
}
```

---

## Best Practices & Troubleshooting

- Always initialize before configuring or preparing workflows
- Handle error callbacks (Result.failure) properly
- Ensure camera permissions are granted before starting workflows
- For production apps, implement secure storage for tokens/credentials

---

## Conclusion

This guide provides all necessary steps to integrate the **Regula IDV SDK** into an iOS application. By following these instructions, developers can build a document verification feature using Regula’s technology.

For further details, refer to the [official Regula IDV SDK documentation](https://docs.regulaforensics.com/develop/idv/) or contact their support team.
