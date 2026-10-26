#!/usr/bin/env bash
# install-tomcat9.sh: install Java 8 and Apache Tomcat 9, listening on port 7070
# Runs once as root when Vagrant provisions the VM (bento/ubuntu-24.04).
set -euo pipefail

TOMCAT_VERSION="9.0.123"
TOMCAT_PORT="7070"
INSTALL_DIR="/opt/tomcat"
TARBALL="apache-tomcat-${TOMCAT_VERSION}.tar.gz"
BASE_URL="https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin"

echo ">>> 1/6 Installing Java 8"
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq
apt-get install -y -qq openjdk-8-jdk-headless curl
jdks=(/usr/lib/jvm/java-8-openjdk-*)      # -amd64 or -arm64, whichever this CPU uses
JAVA_HOME="${jdks[0]}"
"$JAVA_HOME/bin/java" -version

echo ">>> 2/6 Creating the tomcat service account"
id tomcat >/dev/null 2>&1 || useradd -r -U -d "$INSTALL_DIR" -s /usr/sbin/nologin tomcat

echo ">>> 3/6 Downloading Tomcat ${TOMCAT_VERSION} and checking its SHA-512"
cd /tmp
curl -fsSLO "${BASE_URL}/${TARBALL}"
curl -fsSLO "${BASE_URL}/${TARBALL}.sha512"
sha512sum -c "${TARBALL}.sha512"

echo ">>> 4/6 Installing to ${INSTALL_DIR} and setting the port to ${TOMCAT_PORT}"
mkdir -p "$INSTALL_DIR"
tar -xzf "$TARBALL" -C "$INSTALL_DIR" --strip-components=1
sed -i "s/<Connector port=\"8080\"/<Connector port=\"${TOMCAT_PORT}\"/" "$INSTALL_DIR/conf/server.xml"
chown -R tomcat:tomcat "$INSTALL_DIR"

echo ">>> 5/6 Creating and starting the systemd service"
cat > /etc/systemd/system/tomcat.service <<UNIT
[Unit]
Description=Apache Tomcat ${TOMCAT_VERSION}
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment="JAVA_HOME=${JAVA_HOME}"
Environment="CATALINA_HOME=${INSTALL_DIR}"
Environment="CATALINA_BASE=${INSTALL_DIR}"
Environment="CATALINA_PID=${INSTALL_DIR}/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms256m -Xmx512m"
PIDFile=${INSTALL_DIR}/temp/tomcat.pid
ExecStart=${INSTALL_DIR}/bin/startup.sh
ExecStop=${INSTALL_DIR}/bin/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
UNIT
systemctl daemon-reload
systemctl enable --now tomcat

echo ">>> 6/6 Waiting for Tomcat to answer on port ${TOMCAT_PORT}"
for _ in $(seq 1 30); do
    if curl -fs -o /dev/null "http://localhost:${TOMCAT_PORT}/"; then
        echo "Tomcat is up. From your Mac: http://localhost:9090"
        exit 0
    fi
    sleep 2
done
echo "Tomcat did not answer on port ${TOMCAT_PORT}. Check: sudo journalctl -u tomcat" >&2
exit 1
