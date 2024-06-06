# Ruby_Script_Fetch_RDS_Key
-Purpose
--This Ruby script retrieves an RDS key from AWS Secrets Manager and prints it to the console. The script prompts the user to enter their AWS Access Key ID, Secret Access Key, and default region name, and then uses these credentials to authenticate with AWS Secrets Manager.

-Prerequisites
--To run this script, you need to:

---Install AWS SDK for Ruby by running gem install aws-sdk-secretsmanager
---Ensure the secret exists in AWS Secrets Manager with the correct name and region
---Verify the secret's JSON structure contains the rds_key key
---Run bundle install after adding the gem

-How to Use
--Run the script using Ruby: ruby fetch_secret.rb in the Command Line.
--Enter your AWS Access Key ID when prompted.
--Enter your AWS Secret Access Key when prompted.
--Enter your default region name (e.g. us-west-2) when prompted.

-Output
--The script will print the RDS key to the console if successful. If there's an error, it will print an error message.

-How the Code Works
--Here's a step-by-step explanation of how the code works:

--Class FetchSecret
---The script defines a FetchSecret class with two methods: execute and get_secret.

--Method execute
--This method is the entry point of the script. It:

---Prompts the user for AWS credentials: The method prompts the user to enter their AWS Access Key ID, Secret Access Key, and default region name using puts statements.
---Validates the credentials: The method updates the AWS configuration with the provided credentials using Aws.config.update. It then attempts to validate the credentials by creating an Aws::SecretsManager::Client object. If the credentials are invalid, it catches the Aws::Errors::ServiceError exception and prints an error message.
---Retrieves the secret: If the credentials are valid, the method calls the get_secret method to retrieve the secret from AWS Secrets Manager.
---Prints the RDS key: If the secret is retrieved successfully, the method extracts the RDS key from the secret and prints it to the console using puts.

-Method get_secret
--This method retrieves a secret from AWS Secrets Manager. It:

---Creates an AWS Secrets Manager client: The method creates an Aws::SecretsManager::Client object with the provided region name.
---Retrieves the secret value: The method calls the get_secret_value method of the client object to retrieve the secret value.
---Parses the secret value as JSON: The method parses the secret value as JSON using JSON.parse.
---Returns the secret: The method returns the parsed secret value. If an error occurs during the retrieval process, it catches the Aws::SecretsManager::Errors::ServiceError exception and prints an error message.