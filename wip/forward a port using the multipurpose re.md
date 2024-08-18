forward a port using the multipurpose relay tool: socat
socat TCP-LISTEN:6000,fork TCP:127.0.0.1:5000
