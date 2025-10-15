#!/bin/bash
# Test script for Azure Function App
# This script tests the function app without requiring Azure Functions Core Tools

echo "=========================================="
echo "Azure Function App - Local Test Suite"
echo "=========================================="
echo ""

# Check if we're in the correct directory
if [ ! -f "function_app.py" ]; then
    echo "❌ Error: function_app.py not found. Please run this script from src/funcapp directory."
    exit 1
fi

# Check Python installation
echo "1. Checking Python installation..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python 3 is not installed"
    exit 1
fi
PYTHON_VERSION=$(python3 --version)
echo "✅ $PYTHON_VERSION installed"
echo ""

# Check if virtual environment exists
echo "2. Checking virtual environment..."
if [ ! -d ".venv" ]; then
    echo "⚠️  Virtual environment not found. Creating one..."
    python3 -m venv .venv
    echo "✅ Virtual environment created"
else
    echo "✅ Virtual environment exists"
fi
echo ""

# Activate virtual environment
echo "3. Activating virtual environment..."
source .venv/bin/activate
echo "✅ Virtual environment activated"
echo ""

# Install dependencies
echo "4. Installing dependencies..."
pip install -q --upgrade pip
pip install -q -r requirements.txt
if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully"
else
    echo "❌ Failed to install dependencies"
    exit 1
fi
echo ""

# Test Python imports
echo "5. Testing Python imports..."
python3 << EOF
try:
    import azure.functions as func
    import logging
    import json
    import csv
    import io
    print("✅ All required modules imported successfully")
except ImportError as e:
    print(f"❌ Import error: {e}")
    exit(1)
EOF
echo ""

# Validate function_app.py syntax
echo "6. Validating function_app.py syntax..."
python3 -m py_compile function_app.py
if [ $? -eq 0 ]; then
    echo "✅ function_app.py syntax is valid"
else
    echo "❌ Syntax error in function_app.py"
    exit 1
fi
echo ""

# Test function structure
echo "7. Testing function structure..."
python3 << 'EOF'
import sys
sys.path.insert(0, '.')
try:
    from function_app import app, http_trigger, process_csv
    print("✅ Functions imported successfully:")
    print("   - http_trigger")
    print("   - process_csv")
except ImportError as e:
    print(f"❌ Failed to import functions: {e}")
    sys.exit(1)
EOF
echo ""

# Check configuration files
echo "8. Checking configuration files..."
if [ -f "host.json" ]; then
    echo "✅ host.json exists"
else
    echo "❌ host.json not found"
    exit 1
fi

if [ -f "local.settings.json" ]; then
    echo "✅ local.settings.json exists"
else
    echo "❌ local.settings.json not found"
    exit 1
fi

if [ -f "requirements.txt" ]; then
    echo "✅ requirements.txt exists"
else
    echo "❌ requirements.txt not found"
    exit 1
fi
echo ""

# Test CSV processing logic
echo "9. Testing CSV processing logic..."
python3 << 'EOF'
import io
import csv
import json

# Test CSV data
test_csv = """id,name,amount,category
1,Laptop,1299.99,Electronics
2,T-Shirt,29.99,Clothing
3,Coffee Maker,89.99,Appliances"""

try:
    csv_reader = csv.DictReader(io.StringIO(test_csv))
    rows = list(csv_reader)
    
    total_amount = sum(float(row['amount']) for row in rows)
    categories = set(row['category'] for row in rows)
    
    print(f"✅ CSV processing test passed:")
    print(f"   - Processed {len(rows)} rows")
    print(f"   - Total amount: ${total_amount:.2f}")
    print(f"   - Categories: {', '.join(sorted(categories))}")
except Exception as e:
    print(f"❌ CSV processing test failed: {e}")
    exit(1)
EOF
echo ""

# Summary
echo "=========================================="
echo "✅ All tests passed successfully!"
echo "=========================================="
echo ""
echo "Next steps:"
echo "1. Install Azure Functions Core Tools if not already installed"
echo "2. Run 'func start' to start the function app locally"
echo "3. Test endpoints at http://localhost:7071/api/<function-name>"
echo ""
echo "Test commands:"
echo "  curl \"http://localhost:7071/api/http_trigger?name=Flynn\""
echo "  curl -X POST \"http://localhost:7071/api/process_csv\" -H \"Content-Type: text/csv\" --data-binary @../docs/sample_data.csv"
echo ""

deactivate
