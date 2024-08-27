
# Elastic Stack

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Configuration](#configuration)
4. [SSL](#ssl)
5. [Troubleshooting](#troubleshooting)
6. [Contributing](#contributing)

---

## 1. Prerequisites

Before begin the deployment of the Elastic Stack, ensure you have the following prerequisites:

| Prerequisite     | Description                                                     |
| ---------------- | --------------------------------------------------------------- |
| Operating System | This script write for Ubuntu and Debian server                  |
| CPU              | At least 4 vCPU, suggest at least 8 vCPU for better performance |
| Memory           | At least 4GB of RAM. Recommend 16 GB of Ram                     |
| Disk Space       | Disk space for your data and logs. Recommend 200GB for good     |
| Network          | Security Group open neccesarry ports                            |
| SSH              | SSH connection to run remote script                             |

Ensure all these prerequisites are met to avoid any issues during the installation and configuration process.

## 2. Installation
### 2.1. Procedure

This section provides a summary of the steps required to deploy the Elastic Stack. Although the purpose of this repository is to automate the process, understanding the steps involved can be beneficial.

1. **Transfer essential resource**: Copy essentials directories/files to the host
   At the host, stack is store and run at `/opt`

2. **Install docker**: The stack will run in Docker, install Docker and it's required packages

3. **Create persists resource before run Elastic**:
   - Create Docker Network
   - Create directories to persits data
   - Create SSL directory to store SSL resources
   - Verify directories permission
  
4. **Start the stack by docker-compose**: Run the stack which defined in `docker-compose.yml` file
    First time when run the stack, init container will run to create SSL certificates and necessary username/password
    Later run, init container will not run.

5. **Healthy and exit**: Verify containers health and complete the process

6. **(Optional) Post Installation**: Run post install to retrive SSL certificates integrations.


### 2.2. Instruction:
#### 2.2.1. Prepare .env file
`.env` file will content configuration of the stack. Verify and update your desired configration.
Below is descriptions of env vars

| Variable Name      | Description                                               | Suggested Value    |
| ------------------ | --------------------------------------------------------- | ------------------ |
| `STACK_VERSION`    | Version of Elastic stack                                  | >= 8.10.0          |
| `ELASTIC_PASSWORD` | Password for default `elastic` - system admin user        |                    |
| `KIBANA_PASSWORD`  | Password for default `system_kibana` - system kibana user |                    |
| `ES_PORT`          | ElasticSearch exposed port                                | `9200`             |
| `KIBANA_PORT`      | Kibana exposed port (Web UI port)                         | `80`               |
| `APMSERVER_PORT`   | APM Server exposed port for APM integration               | `8200`             |
| `LS_PORT`          | Logstash exposed port for log integration                 | `5044`             |
| `ES_MEM_LIMIT`     | ElasticSearch limit memory                                | `4294967296` (4GB) |
| `KB_MEM_LIMIT`     | Kibana limit memory                                       | `2147483648` (2GB) |
| `APM_MEM_LIMIT`    | Kibana limit memory                                       | `2147483648` (2GB) |
| `LS_MEM_LIMIT`     | Logstash limit memory                                     | `1073741824` (1GB) |
| `ENCRYPTION_KEY`   | Encrypt key for Kibana data                               |                    |

Feel free to update the value to make it fix your requirement


#### 2.2.2. Prepare docker-compose file
Look the file `elk/docker-compose.yml` this the file content the elastic stack.


**It is important to review it before deploy**

This sample stack have:
| Service       | Description                    | Purpose                                                   | Importance               |
| ------------- | ------------------------------ | --------------------------------------------------------- | ------------------------ |
| ElasticSearch | Critical core component        | Centralize, aggregate data and Integration                | Required                 |
| Kibana        | Vital Web UI component         | Dashboard and data visualization                          | Required                 |
| APM Server    | Application monitor component  | Centralize application performance monitoring and tracing | Need if use APM          |
| Logstash      | Key of data pipeline component | Data ingrestion and integration                           | Optional for log ingress |

Feel free add/remove services which you need.

**Then check the environment variables**
This stack current only enable SSL at Elastic Search to save communicate with other component.
But highly recommend to enable SSL in other service if you want to integrate.
If you want to enable SSL, comment out the SSL environment in services in `docker-compose.yml` file
The certificate you for component is created by init container and stored in ssl directory. Use that ssl to integrate with other component

The SSL cert will be create to 
| Service       | SSL            | Status           | Note                            |
| ------------- | -------------- | ---------------- | ------------------------------- |
| ElasticSearch | ssl/es01       | Created/Enabled  | Intergrate with other component |
| Kibana        | ssl/kibana     | Created/Disabled | Expose to Internet              |
| APM Server    | ssl/apm-server | Created/Enabled  | Expose to integrate apm         |
| Logtash       | ssl/logtash    | Created/Enabled  | Expose to integrate logs        |


> **Notice**: Recommend to enable SSL for Kibana because it the Web UI should expose to internet.
> - If you already have domain and certificate, pass that to server and enable SSL for Kibana
> - If you have `https proxy` like CloudFlare, don't need to enable SSL, use proxy to get https connection
> - If you don't mind `self-sign` cert then you can enable SSL which genereted server


#### 2.2.3. Prepare to run script
**Check host which should deploy**.
Check variable `ELASTIC_HOST` in file `run.sh` and edit correct hostname

Check ssh config and verify ssh configuration
```bash
Host <host_name>
        HostName <host_ip>
        Port <ssh_port>
        User <ssh_user>
        IdentityFile <ssh_key_path>
```

**Grant execute permission to the script**

```bash
    $ chmod +x run.sh post-run.sh
```

And ensure the script has execute permisison

```bash
    $ ls -al
```

#### 2.2.4. Run the installation script
Just need to run the script to deploy Elastic stack:
```bash
    $ ./run.sh
```

Then the script will deploy the stack to server, if there and error, it will throw error

#### 2.2.5. Post install (Optional)
There is a script to run optionally after the installation completed.
The script will download certificates which generated while implementing Elastic Stack and convert to `base64` format
```bash
    $ ./post-run.sh
```


## 3. Configuration
### 3.1. ElasticSearch
There is service `setup`. This service will run at first time to setup certs and user in elastic search. You should:
- `ELASTIC_PASSWORD` `KIBANA_PASSWORD` will be set for system users
- Create certs for instances. Update these like follow your stack to have certs for save integrations
```
          echo "Creating certs";
          echo -ne \
          "instances:\n"\
          "  - name: es01\n"\
          "    dns:\n"\
          "      - es01\n"\
          "      - localhost\n"\
          "    ip:\n"\
          "      - 127.0.0.1\n"\
          "      - 172.25.74.3\n"\
          "      - 203.29.19.84\n"\
```
- `xpack.security.transport.ssl` prefix enable ssl at transport
- `ES_JAVA_OPTS` Limit resource of ES can use

### 3.2. Kibana
- Config file placed at `elk/kibana/kibana.yml` will be mount to container.
- `xpack.fleet.packages` will enable integrated packages in Kibana
- `TELEMETRY_OPTIN`: Enable collect user data to elastic search, recommend disable
- `ELASTICSEARCH_SSL_CERTIFICATEAUTHORITIES` use CA cert (created at setup) to authen and verify with elastic search

### 3.3. APM Server
- `output.elasticsearch` are configs send data to elastic search
- `apm-server.kibana` are configs regrading kibana integrations
- `apm-server.kibana.ssl` are configs use ssl when communicate with kibana
- `apm-server.ssl` apm server config ssl
Reference: 
https://www.elastic.co/guide/en/apm/server/7.15/configuring-howto-apm-server.html
https://www.elastic.co/guide/en/apm/server/7.15/securing-apm-server.html

### 3.4. Logstash
- Config file placed in `elk/logstash/config/logstash.yml` and mount into container
- Pipeline files places in `elk/logstash/pipeline` and mount into container
  - Default pipeline is `logstash.conf`
  - In the pipeline is configuration to received data and send data to elasticsearch
- `LS_JAVA_OPTS` Limit resource Logstash can use
- Logstash can config SSL for output but we use stack run at internal. Basically SSL to elastic search don't neccesary.
- If connect to other external elastic search, suggest to set up SSL output
  Reference https://www.elastic.co/guide/en/fleet/current/secure.html

### 3.5. [Integration] - Filebeat (Logging)
Filebeat can integrate directly with ES or can ingress log with Logstash and Logstash integrate with ES.
In this stack we use Logstash for log ingression.
- Use Filebeat as agent to collect log and send data
- Logstash SSL connection defined in pipeline, so that you can to use SSL from Filebeat instead.
  - Use the Filebeat certs and CA cert to authen at agent side
  - Connect to Logstash use SSL
  Reference: https://www.elastic.co/guide/en/beats/filebeat/current/configuration-ssl.html
- If you have your own authorized certificates
  - You can simply use the cert at any side
  - Connect Logstash and Filebeat with SSL enable

### 3.6. [Integration] - APM agent
- Integrate APM agent with server use SSL
  - Download APM server certs and CA certs to authen
  - Use APM server certs to enable SSL and agent side
  - Connect with APM server
    Reference: https://www.elastic.co/guide/en/apm/agent/index.html
- SSL and server side
  - Enable SSL for input at APM server
  - At APM agent use CA certs to verify certs
  - Connect with APM server
  Reference: https://www.elastic.co/guide/en/observability/current/apm-configuration-ssl-landing.html

## 4. SSL
SSL certificates are created at setup step when deploy the stack
And the certificates of each component places in separate directories

| SSL        | Description                               | Use for                   | Note |
| ---------- | ----------------------------------------- | ------------------------- | ---- |
| CA         | Base cert to authorizes other certs/hosts | any SSL component         |      |
| es01       | Certificate of elastic search             | integrate with ES         |      |
| kibana     | Certificate of kibana                     | integrate with kibana     |      |
| apm-server | Certificate of apm-server                 | integrate with apm-server |      |
| logstash   | Certificate of logstash                   | integrate with logstash   |      |
| filebeat   | Certificate of filebeat                   | filebeat integration      |      |

Run `post-run.sh` to download created ssl to local
- Plain SSL certificate will place in `ssl`
- Converted SSL certificates will placed in `ssl-base64`
Use converted `ssl-base64` if you want to integrate and put into kubernetes secrets

## 5. Troubleshooting
## 6. Contributing
