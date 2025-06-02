# 🛡️ Vulnerable Web App Monitoring with ELK Stack

This project sets up a vulnerable web application (Apache + MySQL) inside a Docker container with Filebeat for log shipping and ElastAlert for alerting. It is intended for educational and security monitoring testing purposes.

## 📌 Purpose

This environment allows you to:

- Simulate attacks on a vulnerable web app (DVWA)
- Use tools like **Nmap** or **Metasploit** to generate log events
- Monitor and analyze those events in **Kibana**, using data collected via **Filebeat**
- Trigger Alerts given specified rules via **ElastAlert**

---

## 🧱 Stack Overview

| Component         | Description                                                  |
|------------------|--------------------------------------------------------------|
| **DVWA**          | Damn Vulnerable Web App container (with Apache + MySQL)      |
| **Filebeat**      | Installed inside DVWA to ship Apache logs to Elasticsearch   |
| **Elasticsearch** | Stores and indexes logs                                      |
| **Kibana**        | UI for visualizing and exploring logs                        |
| **ElastAlert**    | Detects suspicious behavior and sends alerts                 |

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/your-user/vuln-monitoring.git
cd vuln-monitoring
```

### 2. Build and Start the Environment

```bash
docker-compose up --build
```

---

## 🌐 Access the Services

| Service         | URL                    | Notes                        |
|----------------|-------------------------|------------------------------|
| **DVWA**        | http://localhost:8080   | Vulnerable app for testing   |
| **Kibana**      | http://localhost:5601   | Log dashboard UI             |
| **Elasticsearch** | http://localhost:9200 | (Optional API access)        |

**Kibana Login:**

- Username: `elastic`
- Password: `changeme`

---

## 🔎 Simulate an Attack

You can generate logs using tools like:

```bash
nmap -A localhost
```

Or by interacting with DVWA from your browser or with tools like **Burp Suite**, **Metasploit**, etc.

Check Kibana → **Discover** for new log entries under the `filebeat-*` index.

---

## 🧰 Filebeat Configuration

Filebeat is installed inside the DVWA container and configured to:

- Read Apache logs from `/var/log/apache2/`
- Ship logs to `elasticsearch:9200`
- Use the `apache` module for parsing

---

## 📂 Project Structure

```
vuln-monitoring/
├── docker-compose.yml         # Defines the services
├── dvwa/
│   ├── Dockerfile             # DVWA + Filebeat
│   ├── start.sh               # Starts all services in container
│   └── filebeat.yml           # Filebeat configuration
```

---

## ✅ Requirements

- Docker
- Docker Compose
- Linux/MacOS or WSL (recommended for networking)

---

## 📣 ElastAlert Email Alerts (via Gmail)

This project includes **ElastAlert** for alerting on suspicious patterns (like 404 spikes).

### 🔔 Gmail SMTP Configuration

To receive email alerts:

1. Create a rule file in `elastalert/rules/404_spike.yaml`:

```yaml
name: "Spike in 404s"
type: frequency
index: filebeat-*
num_events: 5
timeframe:
  minutes: 1
filter:
  - term:
      http.response.status_code: 404
query_key: source.ip

alert:
  - email
email:
  - "your-email@gmail.com"

smtp_host: "smtp.gmail.com"
smtp_port: 587
smtp_ssl: false
smtp_tls: true
from_addr: "your-email@gmail.com"
smtp_auth_file: "/opt/elastalert/smtp_auth.yaml"
```

2. Create the SMTP credentials file in `elastalert/smtp_auth.yaml`:

```yaml
user: "your-email@gmail.com"
password: "your-app-password"
```

3. Update `docker-compose.yml` to mount the auth file:

```yaml
volumes:
  - ./elastalert/smtp_auth.yaml:/opt/elastalert/smtp_auth.yaml
```

4. **Do not commit this password!**
   Add this line to your `.gitignore`:

```
# Secret email credentials
elastalert/smtp_auth.yaml
```

5. Restart ElastAlert:

```bash
docker-compose up -d elastalert
```

Test by triggering several 404s. You'll receive an alert email once the rule matches.

---

## 🧼 Tear Down

To stop and remove all containers:

```bash
docker-compose down
```

---

## 🙏 Credits

- [DVWA](https://github.com/digininja/DVWA)
- [Elastic Filebeat](https://www.elastic.co/beats/filebeat)
- [Elasticsearch](https://www.elastic.co/elasticsearch)
- [Kibana](https://www.elastic.co/kibana)

