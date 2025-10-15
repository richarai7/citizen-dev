# Quick Start Guide

Get up and running with the Azure Function App in under 5 minutes!

## ⚡ Prerequisites Check

Before starting, ensure you have:
- ✅ Python 3.8+ installed
- ✅ Git installed
- ✅ Azure Functions Core Tools v4 (optional for local testing)

## 🚀 5-Minute Setup

### Step 1: Clone the Repository (30 seconds)
```bash
git clone <your-repo-url>
cd citizen-dev
```

### Step 2: Navigate to Function App (10 seconds)
```bash
cd src/funcapp
```

### Step 3: Run the Test Script (2 minutes)
```bash
bash test_local.sh
```

This script will:
- Create a virtual environment
- Install dependencies
- Validate the code
- Run basic tests

### Step 4: Install Azure Functions Core Tools (Optional, 2 minutes)

**Windows (using npm):**
```bash
npm install -g azure-functions-core-tools@4 --unsafe-perm true
```

**macOS (using Homebrew):**
```bash
brew tap azure/functions
brew install azure-functions-core-tools@4
```

**Linux (using npm):**
```bash
npm install -g azure-functions-core-tools@4 --unsafe-perm true
```

### Step 5: Start the Function App (30 seconds)
```bash
# Activate virtual environment first
source .venv/bin/activate  # On Windows: .venv\Scripts\activate

# Start the function app
func start
```

## 🧪 Test Your Functions

### Test 1: Basic HTTP Trigger
Open a new terminal and run:
```bash
curl "http://localhost:7071/api/http_trigger?name=Flynn"
```

Expected response:
```
Hello, Flynn. This HTTP triggered function executed successfully.
```

### Test 2: CSV Processing
```bash
curl -X POST "http://localhost:7071/api/process_csv" \
  -H "Content-Type: text/csv" \
  --data-binary @../../docs/sample_data.csv
```

Expected response (JSON):
```json
{
  "status": "success",
  "summary": {
    "total_rows": 8,
    "processed_rows": 8,
    "total_amount": 2209.91,
    "average_amount": 276.24,
    "unique_categories": ["Appliances", "Clothing", "Electronics"],
    "category_count": 3
  },
  "items": [...]
}
```

## 📝 Next Steps

Now that your function app is running:

1. **Read the Documentation**
   - [Citizen Developer Guide](../docs/CITIZEN_DEV_GUIDE.md)
   - [Copilot Prompts](../docs/COPILOT_PROMPTS.md)

2. **Create Your First Function**
   - Open `function_app.py`
   - Use GitHub Copilot to generate a new HTTP trigger
   - Test it locally

3. **Deploy to Azure**
   - Set up Azure Function App in Azure Portal
   - Configure GitHub secrets
   - Push to main branch to trigger CI/CD

## 🐛 Troubleshooting

### Issue: "func: command not found"
**Solution**: Install Azure Functions Core Tools (see Step 4 above)

### Issue: "Module not found"
**Solution**: Make sure virtual environment is activated and dependencies are installed
```bash
source .venv/bin/activate
pip install -r requirements.txt
```

### Issue: Function app won't start
**Solution**: Check that port 7071 is not in use
```bash
# On macOS/Linux
lsof -i :7071

# On Windows
netstat -ano | findstr :7071
```

### Issue: Import errors in function_app.py
**Solution**: Reinstall dependencies
```bash
pip install -r requirements.txt --force-reinstall
```

## 📚 Additional Resources

- [Azure Functions Documentation](https://learn.microsoft.com/en-us/azure/azure-functions/)
- [Python Developer Guide](https://learn.microsoft.com/en-us/azure/azure-functions/functions-reference-python)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)

## 💡 Pro Tips

1. **Use the test script**: Run `bash test_local.sh` after making changes
2. **Watch mode**: Use `func start --python` for better debugging
3. **VS Code**: Install Azure Functions extension for better development experience
4. **Logs**: Check console output for detailed error messages

## 🎉 Success!

You're now ready to build serverless functions! Start with the sample prompts in [COPILOT_PROMPTS.md](../docs/COPILOT_PROMPTS.md) to create your first custom function.

Happy coding! 🚀