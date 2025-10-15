# Directory Structure

Complete file structure of the Azure Function App template repository.

## Overview

```
citizen-dev/
├── .github/                          # GitHub configuration
│   └── workflows/                    # GitHub Actions workflows
│       └── function-app-ci-cd.yml    # CI/CD pipeline for Azure Functions
│
├── docs/                             # Documentation
│   ├── CITIZEN_DEV_GUIDE.md          # Complete guide for citizen developers
│   ├── COPILOT_PROMPTS.md            # Sample GitHub Copilot prompts
│   ├── DIRECTORY_STRUCTURE.md        # This file - project structure
│   ├── PROJECT_SUMMARY.md            # Project summary and deliverables
│   ├── QUICK_START.md                # 5-minute quick start guide
│   └── sample_data.csv               # Sample CSV data for testing
│
├── infra/                            # Infrastructure as Code
│   └── README.md                     # IaC guide and placeholders
│
├── src/                              # Source code
│   └── funcapp/                      # Azure Function App
│       ├── function_app.py           # Main application with HTTP triggers
│       ├── host.json                 # Function app host configuration
│       ├── local.settings.json       # Local development settings
│       ├── requirements.txt          # Python dependencies
│       └── test_local.sh             # Automated test script
│
├── .gitignore                        # Git ignore patterns
└── README.md                         # Project overview and main documentation
```

## File Descriptions

### Root Level

#### `.gitignore`
Excludes unnecessary files from version control:
- Python cache and compiled files (`__pycache__/`, `*.pyc`)
- Virtual environments (`.venv/`, `venv/`)
- Azure Functions artifacts (`bin/`, `obj/`, `.func/`)
- Local settings (`local.settings.json`, `appsettings.json`)
- OS-specific files (`.DS_Store`, `Thumbs.db`)

#### `README.md`
Main project documentation including:
- Project purpose and description
- Quick start instructions
- Available functions overview
- Links to detailed documentation

### `.github/workflows/`

#### `function-app-ci-cd.yml`
GitHub Actions workflow for continuous integration and deployment:
- **Triggers**: Push to main, pull requests, manual dispatch
- **Build Job**: 
  - Sets up Python 3.11
  - Creates virtual environment
  - Installs dependencies
  - Runs linting with flake8
  - Creates deployment artifact
- **Deploy Job** (commented out):
  - Ready to enable when Azure resources are provisioned
  - Deploys function app to Azure

### `docs/`

#### `CITIZEN_DEV_GUIDE.md`
Comprehensive guide for citizen developers:
- Prerequisites and setup
- Project structure explanation
- Getting started tutorial
- Function usage examples
- Common scenarios (CSV processing, validation)
- Troubleshooting section
- Best practices
- Resource links

#### `COPILOT_PROMPTS.md`
Collection of GitHub Copilot prompts:
- Basic HTTP trigger templates
- Data validation patterns
- CSV processing examples
- Financial calculations
- Date/time processing
- Error handling patterns
- Real-world scenarios with Flynn
- Tips for effective prompting

#### `DIRECTORY_STRUCTURE.md`
This file - complete project structure documentation.

#### `PROJECT_SUMMARY.md`
High-level project summary:
- Objectives and deliverables
- Testing results
- Key features
- Design decisions
- Requirements checklist
- Next steps for production

#### `QUICK_START.md`
Fast-track setup guide:
- 5-minute setup steps
- Test commands
- Troubleshooting
- Pro tips

#### `sample_data.csv`
Sample CSV file for testing:
- 8 rows of data
- Columns: id, name, amount, category
- Categories: Electronics, Clothing, Appliances
- Total amount: $2,209.92

### `infra/`

#### `README.md`
Infrastructure as Code guidance:
- Planned Azure resources
- IaC tool options (Terraform, Bicep, ARM)
- Deployment options
- Required secrets documentation
- Example structure for each IaC tool

### `src/funcapp/`

#### `function_app.py`
Main application file with Azure Functions:

**Function 1: `http_trigger`** (Basic/Dummy)
- **Route**: `/api/http_trigger`
- **Methods**: GET, POST
- **Purpose**: Template function for testing
- **Accepts**: `name` parameter (query string or JSON body)
- **Returns**: Personalized greeting message

**Function 2: `process_csv`** (Real-world example)
- **Route**: `/api/process_csv`
- **Methods**: POST
- **Purpose**: Process CSV data from HTTP request
- **Accepts**: CSV data in request body
- **Validates**: Required columns (id, name, amount, category)
- **Processes**: 
  - Parses CSV data
  - Validates data types
  - Calculates total amount
  - Identifies unique categories
  - Computes average amount
- **Returns**: JSON with summary statistics and processed items
- **Error Handling**: Comprehensive error handling for invalid CSV, missing columns, malformed data

#### `requirements.txt`
Python package dependencies:
```
azure-functions>=1.18.0,<2.0.0
```

#### `host.json`
Function app host configuration:
- Logging configuration
- Application Insights settings
- Extension bundle configuration (v4.x)

#### `local.settings.json`
Local development settings:
- Python runtime configuration
- Local storage emulator settings
- Worker indexing feature flag

**Note**: This file is gitignored and must be created locally.

#### `test_local.sh`
Automated test script:
1. Checks Python installation
2. Creates/activates virtual environment
3. Installs dependencies
4. Tests module imports
5. Validates function syntax
6. Tests CSV processing logic
7. Verifies configuration files
8. Provides next steps

## File Statistics

### Code Files
- **Python**: 1 file (function_app.py) - ~147 lines
- **Shell Scripts**: 1 file (test_local.sh) - ~150 lines
- **Configuration**: 3 files (host.json, local.settings.json, requirements.txt)

### Documentation
- **Markdown Files**: 6 files
- **Total Documentation**: ~800+ lines

### Configuration
- **CI/CD**: 1 workflow file
- **Git**: 1 .gitignore file

### Test Data
- **CSV Files**: 1 sample file (8 rows)

## Usage Patterns

### Development Workflow
```
1. Edit src/funcapp/function_app.py
2. Test with src/funcapp/test_local.sh
3. Run locally with `func start`
4. Test endpoints with curl
5. Commit changes
6. Push to trigger CI/CD
```

### Adding New Functions
```
1. Open src/funcapp/function_app.py
2. Use Copilot prompts from docs/COPILOT_PROMPTS.md
3. Add new @app.route decorator function
4. Test locally
5. Update documentation if needed
```

### Deployment
```
1. Configure Azure resources
2. Set up GitHub secrets
3. Uncomment deployment job in CI/CD
4. Push to main branch
5. Monitor deployment in GitHub Actions
```

## Dependencies

### Runtime Dependencies
- Python 3.8 or higher
- azure-functions library (1.18.0+)

### Development Tools
- Azure Functions Core Tools v4 (optional for local testing)
- Git
- Text editor with GitHub Copilot (recommended)

### Azure Resources (for deployment)
- Azure Function App
- Azure Storage Account
- Application Insights (optional)

## Security Considerations

### Gitignored Files
The following sensitive files are excluded from version control:
- `local.settings.json` - Contains local connection strings
- `.venv/` - Virtual environment with packages
- `__pycache__/` - Python cache files
- Azure Functions artifacts

### Authentication
- HTTP triggers use Function-level authentication
- Auth keys managed in Azure Portal
- Can be upgraded to Azure AD authentication

## Extensibility

### Easy to Add
- New HTTP triggers (add @app.route decorators)
- Blob/Queue triggers (import bindings)
- Helper functions and utilities
- Custom validation logic
- Third-party package integrations

### Infrastructure
- IaC templates in `infra/` directory
- CI/CD pipeline easily customizable
- Environment-specific configurations

## Maintenance

### Regular Updates
- Python dependencies (requirements.txt)
- Azure Functions runtime version
- Documentation for new features
- Sample data for testing

### Monitoring
- Add Application Insights integration
- Configure alerts in Azure
- Review CI/CD pipeline logs
- Monitor function execution metrics

## Best Practices Implemented

✅ Clear separation of concerns (code, docs, infra)
✅ Comprehensive documentation at multiple levels
✅ Automated testing before deployment
✅ Version control with appropriate exclusions
✅ CI/CD pipeline for automation
✅ Error handling and logging
✅ Input validation for security
✅ Sample data for testing
✅ Extensible architecture

## Related Documentation

- [README.md](../README.md) - Project overview
- [QUICK_START.md](QUICK_START.md) - Fast setup
- [CITIZEN_DEV_GUIDE.md](CITIZEN_DEV_GUIDE.md) - Complete guide
- [COPILOT_PROMPTS.md](COPILOT_PROMPTS.md) - Copilot examples
- [PROJECT_SUMMARY.md](PROJECT_SUMMARY.md) - Project summary

---

**Last Updated**: 2025-10-15
**Structure Version**: 1.0
**Status**: ✅ Complete and ready for use
