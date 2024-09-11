@echo off
setlocal enabledelayedexpansion

:: Set keywords to search for (separate with spaces, not commas)
set "KEYWORDS=password passwd pwd pass key secret token api_key api_secret access_key access_secret login username user email phone address ssn social_security cc credit_card ccv cvv dob date_of_birth mother_name pin hostname port UserName db.user db.password db.host db.name db.url server host private_key public_key ssh_key rsa_key ecdsa_key dsa_key jwt_key cookie session session_token auth_token oauth oauth_token client_secret application_id app_id service_account client_id domain fqdn ip_address database_name db_connection sql_query sql_user api_token app_secret app_key consumer_key consumer_secret ssh_private_key ssh_public_key encryption_key master_key kerberos_key azure_access_key aws_access_key gcp_key firebase_key storage_key blob_key vault_key db_connection_string mongo_uri redis_password elasticsearch_password kafka_secret smtp_password proxy_password ldap_password admin_password root_password guest_password mail_server_password cloud_storage_key cloud_storage_secret smtp_server smtp_user azure_storage_connection_string aws_s3_key gcp_storage_key cloudflare_api_key twilio_auth_token sendgrid_api_key paypal_client_secret stripe_secret stripe_key netlify_token heroku_api_key digitalocean_token github_token gitlab_token bitbucket_token slack_token discord_token jira_api_key"

:: Set the log folder
set "LOG_FOLDER=C:\Users\venkateswarlu.k\Downloads"
cd /d "%LOG_FOLDER%"

:: Loop through all .txt files in the directory
for %%f in (*.txt) do (
    set "matched="
    :: Loop through each keyword
    for %%k in (%KEYWORDS%) do (
        for /f "tokens=*" %%a in ('findstr /i /r "\b%%k\b" "%%f"') do (
            set "matched=1"
            echo "%%f": %%a
        )
    )
    if not defined matched (
        echo "%%f": No matches found.
    )
)

pause
