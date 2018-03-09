#!/bin/sh
set -x
echo "Creating Directories"
mkdir -p /data/logs
mkdir -p /data/app

cat << EOF >> /data/app/sample.js
// content of index.js
const http = require('http')
const port = 80

const requestHandler = (request, response) => {
  console.log(request.url)
  response.end('Welcome to your NodeJS Stack.')
}

const server = http.createServer(requestHandler)

server.listen(port, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }

  console.log(`server is listening on 80`)
})
EOF

cd /data/app
nodejs sample.js &

echo "Starting Supervisor"
exec /usr/bin/supervisord -n -c /etc/supervisord.conf