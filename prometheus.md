### prometheus

```markdown
docker run -ti -d --name prometheus -p 9090:9090 -v /home/jackyxiang/prometheus/:/etc/prometheus/ prom/prometheus
```

What in /home/jackyxiang/prometheus/
- prometheus.yml
- hoststats-alert.rules

### prometheus.yml
```markdown
scrape_configs:
  - job_name: dev1_nodes
    scrape_interval: 5s
    static_configs:
      - targets: [172.16.97.85:9100, 172.16.97.64:9100]

  - job_name: dev1_containers
    scrape_interval: 5s
    static_configs:
      - targets: [172.16.97.85:8089, 172.16.97.64:8089]

  - job_name: dev2_nodes
    scrape_interval: 5s
    static_configs:
      - targets: [172.16.97.85:9100, 172.16.97.74:9100]

  - job_name: dev2_containers
    scrape_interval: 5s
    static_configs:
      - targets: [172.16.97.85:8089, 172.16.97.74:8089]
    
alerting:
 alertmanagers:
 - static_configs:
   - targets:
     - 172.16.94.235:9093
rule_files:
  - /etc/prometheus/*.rules
```

### hoststats-alert.rules
```markdown
- name: containers_status
  rules:
  - alert: ContainerKilled
    expr: time() - container_last_seen > 60
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Container killed (instance {{ $labels.instance }})"
      description: "A container has disappeared\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"

  - alert: ContainerCpuUsage
    expr: (sum(rate(container_cpu_usage_seconds_total[3m])) BY (instance, name) * 100) > 80
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Container CPU usage (instance {{ $labels.instance }})"
      description: "Container CPU usage is above 80%\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"

  - alert: ContainerMemoryUsage
    expr: (sum(container_memory_usage_bytes) BY (instance, name) / sum(container_spec_memory_limit_bytes) BY (instance, name) * 100) > 80
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Container Memory usage (instance {{ $labels.instance }})"
      description: "Container Memory usage is above 80%\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"

  - alert: ContainerVolumeUsage
    expr: (1 - (sum(container_fs_inodes_free) BY (instance) / sum(container_fs_inodes_total) BY (instance)) * 100) > 80
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Container Volume usage (instance {{ $labels.instance }})"
      description: "Container Volume usage is above 80%\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"

  - alert: ContainerVolumeIoUsage
    expr: (sum(container_fs_io_current) BY (instance, name) * 100) > 80
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Container Volume IO usage (instance {{ $labels.instance }})"
      description: "Container Volume IO usage is above 80%\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"

  - alert: ContainerHighThrottleRate
    expr: rate(container_cpu_cfs_throttled_seconds_total[3m]) > 1
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "Container high throttle rate (instance {{ $labels.instance }})"
      description: "Container is being throttled\n  VALUE = {{ $value }}\n  LABELS: {{ $labels }}"
```
