require 'aws-sdk-secretsmanager'

require 'json'

class FetchSecret
  def execute
    secret_name = 'your-secret-name'

    region_name = 'us-west-2'

    secret = get_secret(secret_name, region_name)

    if secret

      rds_key = secret['rds_key']

      puts "RDS Key: #{rds_key}"

    else

      puts 'Failed to retrieve the secret from AWS Secrets Manager.'

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
