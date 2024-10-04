
Insecure Data Storage occurs when an application improperly stores sensitive data, such as user credentials, personal information, session tokens, or other critical data, in an insecure location on the device or server. This data is often left unprotected, either unencrypted or without appropriate access controls, making it vulnerable to unauthorized access, theft, or modification by attackers

### Vulnerability Observation:
The thick client application stores its data on the local file system even after the user logs out. This means anyone with access to the local file system can view or retrieve the application’s data, even without logging into the application.

### Impact:
- **Unauthorized Access**: Sensitive information like user data, configurations, or session details could be accessed by anyone with access to the computer.
- **Data Breach**: If sensitive data (e.g., credentials, personal information) is exposed, it can lead to data breaches, identity theft, or other security issues.

### Fix:
- **Clear Data on Logout**: Ensure the application deletes all sensitive data from the local file system once the user logs out.
- **Encryption**: Encrypt any sensitive data stored locally to prevent unauthorized access.
- **Secure Local Storage**: Use secure methods (e.g., OS-protected storage) to store data, and limit access to authorized users only.
