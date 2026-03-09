#!/bin/bash

# ================================================
# NGINX Auto Installer Script
# Author : Mohammad Farhan Almaulidhy
# Description : Install & configure NGINX automatic
# =================================================


LOG_FILE="/var/log/nginx_auto_installer.log"

# --- Helper Functions ---
log() {

  echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

error_exit() {
  log "ERROR: $1"
  exit 1
}

check_root() {
  if [ "$EUID" -ne 0 ]; then
    error_exit "Script must be running as root (use sudo)."
  fi

   echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

error_exit() {
 log "ERROR: $1"
 exit 1
}

check_root() {
 if ["$EUID" -ne 0 ]; then
    error_exit "Script harus dijalankan sebagai root (gunakan sudo)."
 fi

}

detect_os() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
  else

    error_exit "Tidak bisa mendeteksi OS."
=======
   error_exit "Tidak bisa mendeteksi OS."

  fi
}

install_nginx() {
  log "Mengecek apakah NGINX sudah terinstall..."
  if command -v nginx >/dev/null 2>&1; then
    log "NGINX sudah terinstall."
  else
    log "NGINX belum terinstall. Memulai instalasi..."
    if [[ "$OS" == "ubuntu" || "$OS" == "debian" ]]; then

      apt update && apt install -y nginx || error_exit "Gagal install NGINX."
    elif [[ "$OS" == "amzn" || "$OS" == "amazon" ]]; then
      yum install -y nginx || error_exit "Gagal install NGINX."
    else
      error_exit "OS tidak didukung: $OS"

       apt update && apt install -y nginx || error_exit "Gagal install NGINX."
    elif [[ "$OS" == "amzn" || "$OS" == "amazon" ]]; then
       yum install -y nginx || error_exit "Gagal install NGINX."
    else 
       error_exit "OS tidak didukung: $OS"

    fi
    log "NGINX berhasil diinstall."
  fi
}

configure_nginx() {

  log "Membuat custom halaman HTML..."
  cat <<EOF > /var/www/html/index.html

 log "Membuat custom halaman HTML..."
 cat <<EOF > /var/www/html/index.html

<!DOCTYPE html>
<html>
<head>
  <title>NGINX Auto Installer</title>
</head>
<body>
  <h1>NGINX berhasil diinstall!</h1>

  <p>Server ini dikonfigurasi otomatis oleh script bash.</p>
  <p>Hostname: $(hostname)</p>
  <p>Waktu: $(date)</p>

  <p>Server ini dikonfigurasi otomatis oleh script bash</p>
  <p>Hostname : $(hostname)</p>
  <p>Waktu : $(date)</p>

</body>
</html>
EOF
  log "Custom HTML berhasil dibuat."
}

start_nginx() {
  log "Menjalankan dan mengaktifkan NGINX..."
  systemctl start nginx || error_exit "Gagal start NGINX."
  systemctl enable nginx || error_exit "Gagal enable NGINX."
}

check_status() {
  log "Mengecek status NGINX..."
  systemctl status nginx --no-pager | tee -a "$LOG_FILE"
}


# --- Main Execution ---
main() {
  check_root
  detect_os
  install_nginx
  configure_nginx
  start_nginx
  check_status

  log "=========================================="
  log "NGINX setup selesai dengan sukses."
  log "Akses web server di: http://<IP-Server>"
  log "Log tersimpan di: $LOG_FILE"
  log "=========================================="

main() {
 check_root
 detect_os
 install_nginx
 configure_nginx
 start_nginx
 check_status

 log "================================================"
 log "NGINX setup selesai dengan sukses."
 log "Akses web server di : http://<IP-Server>"
 log "Log tersimpan di: $LOG_FILE"
 log "================================================"

}

main
