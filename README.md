# Citizen Developer - Azure Function App Template

An accelerated repository template for citizen developers to quickly build and deploy Azure Functions for data processing scenarios.

## 🎯 Purpose

This template is designed for business users (like Alice from the business team) who need to create serverless functions for processing data, such as CSV files uploaded to Azure Storage. It provides a ready-to-use Azure Function App with HTTP triggers and CI/CD pipelines.

## 📁 Project Structure

```
.github/workflows/    # GitHub Actions CI/CD pipelines
docs/                 # Documentation and guides
  ├── CITIZEN_DEV_GUIDE.md    # Complete guide for citizen developers
  ├── COPILOT_PROMPTS.md      # Sample prompts for GitHub Copilot
  └── sample_data.csv         # Sample CSV for testing
infra/                # Infrastructure as Code (IaC) files
src/funcapp/          # Azure Function App source code
  ├── function_app.py         # Main function app with HTTP triggers
  ├── requirements.txt        # Python dependencies
  ├── host.json              # Function app configuration
  └── local.settings.json    # Local development settings
```

## 🚀 Quick Start

### Prerequisites
- Python 3.8 or higher
- Azure Functions Core Tools v4
- Git

### 1. Clone and Setup
```bash
git clone <your-repo-url>
cd citizen-dev/src/funcapp
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
pip install -r requirements.txt
```

### 2. Run Locally
```bash
func start
```

### 3. Test the Functions
```bash
# Test the basic HTTP trigger
curl "http://localhost:7071/api/http_trigger?name=Alice"

# Test the CSV processing trigger
curl -X POST "http://localhost:7071/api/process_csv" \
  -H "Content-Type: text/csv" \
  --data-binary @../docs/sample_data.csv
```

## 📝 Available Functions

### 1. HTTP Trigger (Dummy)
- **Endpoint**: `/api/http_trigger`
- **Method**: GET, POST
- **Purpose**: Basic template for testing

### 2. Process CSV
- **Endpoint**: `/api/process_csv`
- **Method**: POST
- **Purpose**: Process CSV data and return statistics
- **Use Case**: When Alice uploads a CSV to storage, this function validates, processes, and returns summary data

## 📚 Documentation

- **[Citizen Developer Guide](docs/CITIZEN_DEV_GUIDE.md)** - Complete guide for using this template
- **[Copilot Prompts](docs/COPILOT_PROMPTS.md)** - Sample prompts for generating new functions with GitHub Copilot

## 🤖 Using GitHub Copilot

This template is designed to work seamlessly with GitHub Copilot. See [COPILOT_PROMPTS.md](docs/COPILOT_PROMPTS.md) for example prompts to:
- Generate new HTTP triggers
- Create data validation functions
- Add error handling
- Implement business logic

## 🔄 CI/CD Pipeline

GitHub Actions workflow automatically:
- ✅ Builds and tests Python code
- ✅ Lints code for quality
- ✅ Creates deployment artifacts
- 🚀 Deploys to Azure (when configured)

## 🛠️ Development Workflow

1. **Add new function**: Edit `src/funcapp/function_app.py`
2. **Test locally**: Run `func start` and test with curl/Postman
3. **Commit changes**: Push to GitHub
4. **Auto-deploy**: CI/CD pipeline deploys to Azure

## 🎓 Example Scenario

Alice, a business analyst, needs to process sales data:
1. Creates a CSV with columns: id, name, amount, category
2. Uses the `/api/process_csv` endpoint to validate and analyze data
3. Receives JSON response with totals, averages, and category breakdown
4. Integrates the API into business workflows

## 📖 Learn More

- [Azure Functions Python Guide](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python)
- [Azure Functions Best Practices](https://learn.microsoft.com/en-us/azure/azure-functions/functions-best-practices)

## 🤝 Contributing

This is a template repository. Fork it and customize for your needs!

## 📄 License

MIT License - Feel free to use this template for your projects.
