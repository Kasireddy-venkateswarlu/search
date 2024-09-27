1. Disable Password Authentication: Set `PasswordAuthentication no` in `/etc/ssh/sshd_config`.
   
2. **Use SSH Key Authentication**: Configure public/private key pairs for SSH login.

3. **Change Default SSH Port**: Modify the SSH port from 22 to another, e.g., `Port 2222` in `/etc/ssh/sshd_config`.

4. **Disable Root Login**: Set `PermitRootLogin no` to prevent direct root access.

5. **Limit SSH Users**: Use `AllowUsers username` to restrict SSH access to specific users.

6. **Install Fail2ban**: Install and configure **Fail2ban** to block IPs after failed login attempts.

7. **Set Max Login Attempts**: Use `MaxAuthTries 3` to limit failed SSH login attempts.

8. **Enable Firewall**: Allow SSH only through a firewall like UFW or iptables.


