import random

def lambda_handler(event, context):
    # Generate a random credit limit between 0 and 9999
    cred_limit = random.randint(0, 9999)
    
    # Return the generated credit limit
    return {
        'credit_limit': cred_limit
    }
    