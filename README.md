🛡️ Vulnerable Web App Monitoring with ELK Stack

This project sets up a vulnerable DVWA container instrumented with Filebeat, alongside an Elasticsearch + Kibana (ELK) stack, to simulate attacks and monitor logs for detection and analysis.
📌 Purpose

This environment allows you to:

    Simulate attacks on a vulnerable web app (DVWA)

    Use tools like Nmap or Metasploit to generate log events

    Monitor and analyze those events in Kibana, using data collected via Filebeat

🧱 Stack Overview
Component	Description
DVWA	Damn Vulnerable Web App container (with Apache + MySQL)
Filebeat	Installed inside DVWA to ship Apache logs to Elasticsearch
Elasticsearch	Stores and indexes logs
Kibana	UI for visualizing and exploring logs
🚀 Getting Started
1. Clone the Repository

git clone https://github.com/your-user/vuln-monitoring.git
cd vuln-monitoring

2. Build and Start the Environment

docker-compose up --build

🌐 Access the Services
Service	URL	Notes
DVWA	http://localhost:8080	Vulnerable app for testing
Kibana	http://localhost:5601	Log dashboard UI
Elasticsearch	http://localhost:9200	(Optional API access)

    Kibana Login:
    Username: elastic
    Password: changeme

🔎 Simulate an Attack

You can generate logs using tools like:

nmap -A localhost

Or by interacting with DVWA from your browser or with tools like Burp Suite, Metasploit, etc.

Check Kibana → Discover for new log entries under the filebeat-* index.
🧰 Filebeat Configuration

Filebeat is installed inside the DVWA container and configured to:

    Read Apache logs from /var/log/apache2/

    Ship logs to elasticsearch:9200

    Use the apache module for parsing

📂 Project Structure

vuln-monitoring/
├── docker-compose.yml         # Defines the services
├── dvwa/
│   ├── Dockerfile             # DVWA + Filebeat
│   ├── start.sh               # Starts all services in container
│   └── filebeat.yml           # Filebeat configuration

✅ Requirements

    Docker

    Docker Compose

    Linux/MacOS or WSL (recommended for networking)

🧼 Tear Down

To stop and remove all containers:

docker-compose down

🙏 Credits

    DVWA

    Elastic Filebeat

    Elasticsearch

    Kibana
