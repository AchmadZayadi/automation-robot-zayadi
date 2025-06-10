env GOOS=linux GOARCH=amd64 go build -o nc-ottopoint-loyalty-clean

# scp -i ~/.ssh/LightsailDefaultKey-ap-southeast-1-new.pem nc-ottopoint-loyalty ubuntu@13.228.25.85:/home/ubuntu

scp config.development.yml lukman@34.101.248.102:/home/build