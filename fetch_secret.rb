require 'aws-sdk-secretsmanager'
require 'json'

class FetchSecret
  def get_secret(secret_name, region_name)
    client = Aws::SecretsManager::Client.new(
    region: 'us-west-2',
    credentials: Aws.config[:credentials]
    )

    begin
      response = client.get_secret_value(secret_id: 'rds!cluster-95540029-b00e-44a4-a6c7-be31c5224351')

      if response.secret_string
        JSON.parse(response.secret_string)
      else
        puts "Secret string is empty for secret: #{secret_name}"
      end

    rescue Aws::SecretsManager::Errors::ServiceError => e
      puts "Error retrieving secret: #{e.message}"
    rescue => e
      puts "Unexpected error: #{e.message}"
    end
  end


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

      secret_name = 'rds!cluster-95540029-b00e-44a4-a6c7-be31c5224351'
      puts "Retrieving secret: #{secret_name}"

      secret = get_secret(secret_name, region_name)

      if secret
        puts "Retrieved RDS secret: #{secret}"
      else
        puts "Failed to retrieve secret: #{secret_name}"
      end

    rescue Aws::Errors::ServiceError => e
      puts "Error: #{e.message}"
    end
  end
end
FetchSecret.new.execute # calls upon the class method to run
