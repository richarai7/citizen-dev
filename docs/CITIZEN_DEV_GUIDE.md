# Citizen Developer Guide - Azure Function App

## Overview
This repository serves as an accelerated template for citizen developers to quickly develop Azure Functions for data processing scenarios, such as processing CSV files uploaded to Azure Storage.

## Prerequisites
- Python 3.8 or higher
- Azure Functions Core Tools v4
- Azure Storage Account (for production use)
- Git

## Project Structure
```
.github/          # GitHub Actions CI/CD workflows
docs/            # Documentation
infra/           # Infrastructure as Code (IaC) files
src/funcapp/     # Azure Function App source code
```

## Getting Started

### 1. Clone the Repository
```bash
git clone <repository-url>
cd citizen-dev
```

### 2. Set Up Python Virtual Environment
```bash
cd src/funcapp
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

### 3. Install Dependencies
```bash
pip install -r requirements.txt
```

### 4. Run the Function App Locally
```bash
func start
```

The function app will start on `http://localhost:7071`

### 5. Test the HTTP Trigger
Open a browser or use curl to test:
```bash
curl "http://localhost:7071/api/http_trigger?name=Flynn"
```

Expected response:
```
Hello, Flynn. This HTTP triggered function executed successfully.
```

## Available Functions

### 1. HTTP Trigger (Dummy)
- **Endpoint**: `/api/http_trigger`
- **Method**: GET, POST
- **Description**: Basic HTTP trigger that accepts a name parameter and returns a greeting
- **Usage**: For testing and template purposes

### 2. Process CSV HTTP Trigger
- **Endpoint**: `/api/process_csv`
- **Method**: POST
- **Description**: Processes CSV data from request body or Azure Blob Storage
- **Usage**: Real-world example for CSV processing scenarios

## Adding New Functions

### Using Copilot to Generate Functions

You can use GitHub Copilot to help generate new HTTP trigger functions. Here's a sample prompt:

**Prompt Example:**
```
Create a new HTTP trigger Azure Function in Python (v2 model, isolated) that:
1. Accepts a POST request with CSV data
2. Validates the CSV has required columns: id, name, amount
3. Calculates the sum of the amount column
4. Returns a JSON response with the total and row count
```

### Manual Creation
To add a new HTTP trigger function, edit `function_app.py`:

```python
@app.route(route="my_new_trigger")
def my_new_trigger(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('My new trigger function processed a request.')
    # Your logic here
    return func.HttpResponse("Success", status_code=200)
```

## Configuration

### Local Settings (`local.settings.json`)
This file contains local development settings and is not committed to source control.

```json
{
  "IsEncrypted": false,
  "Values": {
    "FUNCTIONS_WORKER_RUNTIME": "python",
    "AzureWebJobsStorage": "UseDevelopmentStorage=true"
  }
}
```

### Application Settings (Azure)
For production deployment, configure these in Azure Portal or via Azure CLI:
- `AzureWebJobsStorage`: Connection string to Azure Storage Account
- `FUNCTIONS_WORKER_RUNTIME`: Set to `python`
- Custom app settings as needed

## Deployment

### Using GitHub Actions
The CI/CD pipeline is configured in `.github/workflows/`. Push to the main branch to trigger automated deployment.

### Manual Deployment
```bash
func azure functionapp publish <your-function-app-name>
```

## Common Scenarios

### Scenario 1: CSV File Processing from Azure Blob Storage
Flynn, a business user, uploads a CSV file to Azure Storage. The function app:
1. Receives an HTTP trigger with the blob URL or connection details
2. Downloads and processes the CSV
3. Performs business logic (validation, transformation, calculation)
4. Returns results or stores processed data

See `process_csv` function for implementation example.

### Scenario 2: Data Validation and Transformation
Process incoming data through HTTP requests, validate formats, transform data structures, and return processed results.

## Troubleshooting

### Function App Won't Start
- Ensure Python virtual environment is activated
- Verify all dependencies are installed: `pip install -r requirements.txt`
- Check that Azure Functions Core Tools is installed: `func --version`

### HTTP Trigger Not Responding
- Verify the function app is running: Check console output
- Confirm the correct endpoint URL: `http://localhost:7071/api/<function-name>`
- Check function logs in the console

### Import Errors
- Ensure you're in the virtual environment
- Reinstall dependencies: `pip install -r requirements.txt --force-reinstall`

## Best Practices
1. **Keep functions focused**: Each function should have a single responsibility
2. **Use logging**: Add appropriate logging for debugging and monitoring
3. **Error handling**: Always include try-catch blocks for external operations
4. **Configuration**: Use app settings for environment-specific values
5. **Testing**: Test locally before deploying to Azure

## Resources
- [Azure Functions Python Developer Guide](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python)
- [Azure Functions HTTP Trigger](https://learn.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook-trigger)
- [Azure Functions Best Practices](https://learn.microsoft.com/en-us/azure/azure-functions/functions-best-practices)

## Support
For questions or issues:
1. Check the documentation in the `docs/` folder
2. Review existing function implementations in `src/funcapp/`
3. Contact the development team
4. Use GitHub Copilot to ask questions about the code
