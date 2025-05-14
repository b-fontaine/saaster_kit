# SafeLine Web Application Firewall

SafeLine is a self-hosted Web Application Firewall (WAF) that protects your web applications from attacks and exploits.

## Features

- **Block Web Attacks**: Defends against SQL injection, XSS, code injection, command injection, CRLF injection, XXE, SSRF, path traversal, and more.
- **Rate Limiting**: Protects against DoS attacks, brute force attempts, and traffic surges.
- **Anti-Bot Challenge**: Blocks bots while allowing human users.
- **Authentication Challenge**: Requires password authentication for visitors.
- **Dynamic Protection**: Dynamically encrypts HTML and JS code.

## Configuration

SafeLine is configured to protect all routes in the Kong API Gateway. The plugin is applied globally to secure all traffic.

### Management UI

The SafeLine Management UI is accessible at:

```
https://localhost:9443
```

Default credentials:
- Username: admin
- Password: admin

**Important**: Change the default password after the first login.

## Protection Modes

SafeLine offers two protection modes:

1. **Balance Mode**: Provides good protection with minimal false positives.
2. **Strict Mode**: Provides maximum protection but may have more false positives.

The current configuration uses the **Strict Mode** for maximum security.

## Customizing Protection Rules

You can customize the protection rules through the SafeLine Management UI:

1. Log in to the Management UI at https://localhost:9443
2. Navigate to "Protection Rules"
3. Enable or disable specific rules as needed
4. Apply changes

## Integration with Kong

SafeLine is integrated with Kong API Gateway using the `kong-safeline` plugin. The plugin is configured to send all requests to the SafeLine detector for analysis.

If a malicious request is detected, it will be blocked with a 403 Forbidden response.
