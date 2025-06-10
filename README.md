# run automation robotframework
1. pip install -r requirements.txt
2. brew install python3
3. Open Terminal jalankan sh run.sh

# run automation docker - just for study
1. install docker dekstop: https://www.docker.com/
2. docker build --no-cache -t testing-payment . OR docker build -t testing-payment .
3. docker run --rm --name testing-payment -v "$(pwd)/results:/testing-payment/results" testing-payment

