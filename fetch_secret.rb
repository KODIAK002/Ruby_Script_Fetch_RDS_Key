require 'aws-sdk-secretsmanager'
require 'json'

class FetchSecret
  def execute
    puts 'Enter your AWS Access Key ID:'
    access_key_id = gets.chomp

    puts 'Enter your AWS Secret Access Key:'
    secret_access_key = gets.chomp

    puts 'Enter your default region name (e.g. us-west-2):'
    region_name = gets.chomp

    # Validate the credentials
    begin
      Aws.config.update({
        region: region_name,
        credentials: Aws::Credentials.new(access_key_id, secret_access_key)
      })

      # Retrieve the secret
      secret_name = 'your-secret-name'
      secret = get_secret(secret_name, region_name)

      if secret
        rds_key = secret['rds_key']
        puts "RDS Key: #{rds_key}"
      else
        puts 'Failed to retrieve the secret from AWS Secrets Manager.'
      end
    rescue Aws::Errors::ServiceError => e
      puts "Error validating credentials: #{e.message}"
    end
  end

  def get_secret(secret_name, region_name)
    client = Aws::SecretsManager::Client.new(region: region_name)

    begin
      response = client.get_secret_value(secret_id: secret_name)

      secret = JSON.parse(response.secret_string) if response.secret_string

      secret
    rescue Aws::SecretsManager::Errors::ServiceError => e
      puts "Error retrieving secret: #{e.message}"

      nil
    end
  end
end

FetchSecret.new.execute # calls upon the class method to run
