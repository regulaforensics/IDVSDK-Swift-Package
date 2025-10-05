# **IDV SDK Integration Guide**

## **Introduction**

This guide provides step-by-step instructions on integrating the **IDV SDK** into an iOS application. 
It covers initialization, API configuration, workflow setup, and starting the ID verification process.

---

## **1. Prerequisites**

Before integrating the SDK, ensure the following:

- iOS **SDK o+**
- **Camera permission** enabled
- Regula IDVSDK dependency added to `Podfile` 


2. In your **app-level** `build.gradle.kts`, add the following dependency:

```kotlin
implementation("com.regula.documentreader.core:fullrfid:7.5+@aar") {}
implementation("com.regula.idv:docreader:1.0.29@aar") {
        isTransitive = true
    }
implementation("com.regula.idv:api:1.0.17@aar") {
        isTransitive = true
    }
```

Sync Gradle after adding the dependencies.

---

## **3. Update AndroidManifest.xml**

Ensure the following permissions and features are included:

```xml
<uses-feature android:name="android.hardware.camera" android:required="true" />
<uses-permission android:name="android.permission.CAMERA"/>
```

---

## **4. Initiate the Handshake with IDCanopy**
In your `MainActivity.kt`, initiate the Handshake with IDCanopy by calling the **https://api-umbrella.io/api/sdk/document/handshake** endpoint.

An example of the Hanshake function in your `MainActivity.kt` could look like this:

```kotlin
import io.ktor.client.*
import io.ktor.client.request.*
import io.ktor.client.statement.*
import io.ktor.client.engine.cio.*
import io.ktor.http.*
import kotlinx.coroutines.*

class MainActivity : AppCompatActivity() {
        runBlocking {
        callHandshakeAPI()
    }
}

suspend fun callHandshakeAPI() {
    val idcHandshakeUrl = "https://api-umbrella.io/api/sdk/document/handshake"
    val idcCustomerId = "your customer id from IDCanopy"
    val client = HttpClient(CIO) // CIO is a coroutine-based engine

    try {
        val response: HttpResponse = client.post(idcHandshakeUrl) {
            contentType(ContentType.Application.Json)
            setBody(
                """
                {
                    "customerId": idcCustomerId,
                    "processName": "customWL",
                    "validationData": {
                        "fullName": "",
                        "firstName": "Matthias",
                        "lastName": "Wolgemar",
                        "dob": "1985-11-03",
                        "disabilityCheck": "True"
                    }
                }
                """.trimIndent()
            )
        }

        println("Response status: ${response.status}")
        println("Response body: ${response.bodyAsText()}")
    } catch (e: Exception) {
        println("Error: ${e.message}")
    } finally {
        client.close()
    }
}
```
You will receive a `JSON` response with these 3 fields:

```JSON
{
    "transaction_id": "6c9e5700-d4bb-4e72-8523-882fb2128f91",
    "ui_handle": "59ec73a4-cea5-4cdd-892a-fe3504bedd3e",
    "init_timestamp": "20/03/2025, 12:11:25"
}
```
The **transaction_id** is your unique transactionId with IDCanopy.

## **5. Initialize Regula IDV SDK**

In your `MainActivity.kt`, initialize the SDK with the **Document Reader Module**:

```kotlin
import com.regula.idv.api.IdvSdk
import com.regula.idv.docreader.DocReaderModule
import com.regula.idv.api.config.IdvInitConfig

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val config = IdvInitConfig(listOf(DocReaderModule()))
        IdvSdk.instance().initialize(this, config) {
            // Handle initialization result
        }
    }
}
```

---

## **6. Configure API Settings**

Before using the SDK, configure the API connection:

```kotlin
import com.regula.idv.api.config.IdvUrlConfig
import com.regula.idv.api.config.IdvConnectionConfig

val HOST = "your_host"
val USER_NAME = "your_username"
val PASSWORD = "your_password"
val IS_SECURE = true

IdvSdk.instance().configure(this, IdvConnectionConfig(HOST, USER_NAME, PASSWORD, IS_SECURE)) {}
```
The values for `your_username` and `your_password` will be shared with you and is different from your IDCanopy Customer Id.

---

## **7. Prepare and Start an ID Verification Workflow**

Prepare a workflow before starting the verification:

`your_workflow_id` is dependent on wheter the disability check is on or off.

If disablity check in ON, the value of `your_workflow_id` will be "WorkflowXXX", otherwise, it will be "WorkflowYYY". 

**We will confirm the workflow ids before we start integration.**

```kotlin
import com.regula.idv.api.config.IdvPrepareWorkflowConfig

val workflowId = "your_workflow_id"
IdvSdk.instance().prepareWorkflow(this, IdvPrepareWorkflowConfig(workflowId)) {}
```

Start the workflow when ready:

```kotlin
IdvSdk.instance().startWorkflow(this) { sessionResult, error ->
    if (error == null) {
        // Handle successful verification
    } else {
        // Handle error
    }
}
```

With metadata: 

In the metadata, you will include the **ui_handle** that you received from the handshake with IDCanopy as `key1` and `value1` and the language selection as `key2` and `value2`. 

For example: 

`key1` would be written as **"ui_handle"**

`value1` would be written as **"59ec73a4-cea5-4cdd-892a-fe3504bedd3e"**

`key2` would be written as **"locale"**

`value2` would be written as **"en-us"** for English or **"de-DE"** for German

```kotlin
val metadata = JSONObject()
metadata.put("key", "value")
IdvSdk.instance().startWorkflow(this, metadata) { sessionResult, error ->
    if (error == null) {
        // Handle successful verification
    } else {
        // Handle error
    }
}
```

---

## **8. Best Practices & Troubleshooting**

- **Ensure all necessary dependencies** are included in `build.gradle.kts`.
- **Handle API failures** by checking the `sessionResult` and `error` callbacks.
- **Grant camera permissions** before starting the workflow.
- **Use proper credentials** when configuring `IdvConnectionConfig`.

---

## **Conclusion**

This guide provides all necessary steps to integrate the **Regula IDV SDK** into an Android application. By following these instructions, developers can build a document verification feature using Regula’s technology.

For further details, refer to the **official Regula IDV SDK documentation** or contact their support team.
