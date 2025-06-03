# Kong Gateway Monitoring & Observability Setup

## Prometheus Integration

### Metrics Collection
The Kong Prometheus plugin has been configured to collect comprehensive metrics:

```yaml
- name: prometheus
  config:
    per_consumer: true
    status_code_metrics: true
    latency_metrics: true
    bandwidth_metrics: true
    upstream_health_metrics: true
```

### Available Metrics

#### Request Metrics
- `kong_http_requests_total`: Total HTTP requests by service, route, method, and status
- `kong_request_latency_ms`: Request latency in milliseconds
- `kong_upstream_latency_ms`: Upstream service latency

#### Bandwidth Metrics
- `kong_bandwidth_bytes`: Total bandwidth by service and route
- `kong_request_size_bytes`: Request payload size
- `kong_response_size_bytes`: Response payload size

#### Health Metrics
- `kong_upstream_target_health`: Upstream target health status
- `kong_datastore_reachable`: Kong datastore connectivity

### Accessing Metrics
- **Endpoint**: `http://localhost:8001/metrics`
- **Format**: Prometheus exposition format
- **Authentication**: Admin API access required

## Health Checks Configuration

### Website Service Health Check
```yaml
upstreams:
  - name: website-upstream
    targets:
      - target: website:80
        weight: 100
    healthchecks:
      active:
        type: http
        http_path: "/"
        healthy:
          interval: 10
          successes: 2
        unhealthy:
          interval: 10
          http_failures: 3
          timeouts: 3
      passive:
        healthy:
          successes: 3
        unhealthy:
          http_failures: 3
          timeouts: 3
```

### Customer Service Health Check
```yaml
  - name: customer-service-upstream
    targets:
      - target: customer_service:50051
        weight: 100
    healthchecks:
      active:
        type: tcp
        healthy:
          interval: 10
          successes: 2
        unhealthy:
          interval: 10
          tcp_failures: 3
          timeouts: 3
      passive:
        healthy:
          successes: 3
        unhealthy:
          tcp_failures: 3
          timeouts: 3
```

## Status API Configuration

### Endpoint Configuration
- **Listen Address**: `0.0.0.0:8100`
- **Access**: Internal network only
- **Format**: JSON status information

### Available Status Information
- Kong version and configuration
- Database connectivity status
- Plugin status and configuration
- Memory usage and performance metrics

### Example Status Response
```json
{
  "database": {
    "reachable": true
  },
  "memory": {
    "workers_lua_vms": [
      {
        "http_allocated_gc": "18.73 MiB",
        "pid": 123
      }
    ]
  },
  "server": {
    "connections_accepted": 1000,
    "connections_active": 10,
    "connections_handled": 1000,
    "connections_reading": 0,
    "connections_waiting": 5,
    "connections_writing": 5,
    "total_requests": 5000
  }
}
```

## Logging Configuration

### Log Levels
- **Current Level**: `notice`
- **Access Logs**: Enabled to stdout
- **Error Logs**: Enabled to stderr

### Log Format
Kong uses the standard Nginx log format with additional Kong-specific fields:
- Request ID for tracing
- Service and route information
- Upstream response times
- Plugin execution times

### Log Rotation
Logs are handled by Docker's logging driver:
- **Driver**: json-file
- **Max Size**: 100MB per file
- **Max Files**: 5 files retained

## Integration with Existing Monitoring

### Grafana Integration
The existing Grafana instance can be configured to scrape Kong metrics:

1. **Add Prometheus Data Source**:
   - URL: `http://kong:8001/metrics`
   - Scrape Interval: 15s

2. **Import Kong Dashboard**:
   - Use community Kong dashboard templates
   - Customize for saaster_kit specific services

### SafeLine WAF Monitoring
Kong monitoring complements the existing SafeLine WAF monitoring:
- Kong provides application-level metrics
- SafeLine provides security event monitoring
- Combined view offers comprehensive observability

## Alerting Recommendations

### Critical Alerts
- Upstream service health failures
- High error rates (>5% 5xx responses)
- Excessive latency (>1000ms p95)
- Rate limiting threshold breaches

### Warning Alerts
- Memory usage >80%
- Cache hit ratio <70%
- Unusual traffic patterns
- Plugin execution errors

### Alert Configuration Example
```yaml
groups:
  - name: kong-alerts
    rules:
      - alert: KongUpstreamDown
        expr: kong_upstream_target_health == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: "Kong upstream {{ $labels.upstream }} is down"
          
      - alert: KongHighErrorRate
        expr: rate(kong_http_requests_total{status=~"5.."}[5m]) > 0.05
        for: 2m
        labels:
          severity: warning
        annotations:
          summary: "High error rate detected"
```

## Performance Monitoring

### Key Performance Indicators
- **Request Rate**: Requests per second by service
- **Response Time**: P50, P95, P99 latencies
- **Error Rate**: 4xx and 5xx response percentages
- **Cache Hit Ratio**: Proxy cache effectiveness
- **Upstream Health**: Backend service availability

### Monitoring Dashboards
Create dashboards to track:
- Service-level performance metrics
- Rate limiting effectiveness
- Cache performance
- Security events correlation

## Troubleshooting

### Common Issues
1. **Metrics Not Available**: Check Prometheus plugin configuration
2. **Health Checks Failing**: Verify upstream service connectivity
3. **High Memory Usage**: Adjust cache size or worker configuration
4. **Missing Logs**: Check Docker logging configuration

### Debug Commands
```bash
# Check Kong status
curl http://localhost:8100/status

# View metrics
curl http://localhost:8001/metrics

# Check plugin configuration
curl http://localhost:8001/plugins

# View upstream health
curl http://localhost:8001/upstreams/website-upstream/health
```
