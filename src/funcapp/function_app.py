import azure.functions as func
import logging
import json
import csv
import io

app = func.FunctionApp(http_auth_level=func.AuthLevel.FUNCTION)

@app.route(route="http_trigger")
def http_trigger(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    name = req.params.get('name')
    if not name:
        try:
            req_body = req.get_json()
        except ValueError:
            pass
        else:
            name = req_body.get('name')

    if name:
        return func.HttpResponse(f"Hello, {name}. This HTTP triggered function executed successfully.")
    else:
        return func.HttpResponse(
             "This HTTP triggered function executed successfully. Pass a name in the query string or in the request body for a personalized response.",
             status_code=200
        )


@app.route(route="process_csv", methods=["POST"])
def process_csv(req: func.HttpRequest) -> func.HttpResponse:
    """
    Process CSV data from HTTP request.
    
    Example use case: Flynn from business team uploads CSV data to be processed.
    This function validates, transforms, and returns summary statistics.
    
    Expected CSV format:
    id,name,amount,category
    1,Item A,100.50,Electronics
    2,Item B,250.75,Clothing
    
    Returns:
    JSON with summary statistics including total amount, row count, and categories.
    """
    logging.info('Processing CSV data from HTTP request.')
    
    try:
        # Get CSV data from request body
        csv_content = req.get_body().decode('utf-8')
        
        if not csv_content:
            return func.HttpResponse(
                json.dumps({"error": "No CSV data provided in request body"}),
                status_code=400,
                mimetype="application/json"
            )
        
        # Parse CSV data
        csv_reader = csv.DictReader(io.StringIO(csv_content))
        rows = list(csv_reader)
        
        if not rows:
            return func.HttpResponse(
                json.dumps({"error": "CSV is empty"}),
                status_code=400,
                mimetype="application/json"
            )
        
        # Validate required columns
        required_columns = ['id', 'name', 'amount', 'category']
        if not all(col in rows[0].keys() for col in required_columns):
            return func.HttpResponse(
                json.dumps({
                    "error": f"CSV must contain columns: {', '.join(required_columns)}",
                    "found_columns": list(rows[0].keys())
                }),
                status_code=400,
                mimetype="application/json"
            )
        
        # Process data
        total_amount = 0.0
        categories = set()
        processed_items = []
        
        for row in rows:
            try:
                amount = float(row['amount'])
                total_amount += amount
                categories.add(row['category'])
                
                processed_items.append({
                    'id': row['id'],
                    'name': row['name'],
                    'amount': amount,
                    'category': row['category']
                })
            except (ValueError, KeyError) as e:
                logging.warning(f"Skipping invalid row: {row}. Error: {str(e)}")
                continue
        
        # Calculate statistics
        average_amount = total_amount / len(processed_items) if processed_items else 0
        
        # Build response
        result = {
            "status": "success",
            "summary": {
                "total_rows": len(rows),
                "processed_rows": len(processed_items),
                "total_amount": round(total_amount, 2),
                "average_amount": round(average_amount, 2),
                "unique_categories": sorted(list(categories)),
                "category_count": len(categories)
            },
            "items": processed_items
        }
        
        logging.info(f"Successfully processed {len(processed_items)} items. Total: ${total_amount:.2f}")
        
        return func.HttpResponse(
            json.dumps(result, indent=2),
            status_code=200,
            mimetype="application/json"
        )
        
    except Exception as e:
        logging.error(f"Error processing CSV: {str(e)}")
        return func.HttpResponse(
            json.dumps({
                "error": "Internal error processing CSV",
                "details": str(e)
            }),
            status_code=500,
            mimetype="application/json"
        )
