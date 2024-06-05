# Ruby_Script_Fetch_RDS_Key
The Scripts purpose is Fetching  a RDS Key from AWS Secrets Manager

This script retrieves an RDS key from  AWS Secrets Manager and prints it to the console programatically by using the Command Line

=Prerequisites for the script to be able to run

--AWS CLI configured with necessary credentials and permissions to access the secret
--AWS SDK for Ruby installed (gem 'aws-sdk-secretsmanager')
--Secret exists in AWS Secrets Manager with the correct name and region
--Secret's JSON structure contains the rds_key key
--Make sure to run bundle install after adding the gem

-How to modify the script for your use

--Replace 'your-secret-name' with the actual name of your secret in 
fetch.secret.rb.
--Replace 'us-west-2' with the actual region where your secret is stored in fetch.secret.rb.
--Run the script using Ruby: ruby fetch.secret.rb in the Command Line

-Output given by the script

--The script will print the RDS key to the console if successful. If there's an error, it will print an error message.

