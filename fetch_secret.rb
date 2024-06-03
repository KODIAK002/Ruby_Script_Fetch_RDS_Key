require 'aws-sdk-secretsmanager'
require 'json'

def get_secret(secret_name)
  region_name = 'your-aws-region'  # example, 'us-west-2'

  # Create a Secrets Manager client
  client = Aws::SecretsManager::Client.new(region: region_name)

  begin
    # Retrieve the secret value
    response = client.get_secret_value(secret_id: secret_name)
    secret = response.secret_string
    JSON.parse(secret)  # put json for now until can ask
  rescue Aws::SecretsManager::Errors::ServiceError => e
    puts "Error retrieving secret: #{e.message}"
    nil
  end
end

# Usage example
secret_name = 'your-secret-name'  # The name of my secret in Secrets Manager
secret = get_secret(secret_name)

if secret
  rds_key = secret['rds_key']  # Adjust based on my secret's JSON structure
  puts "RDS Key: #{rds_key}"
else
  puts "Failed to retrieve the secret."
end
