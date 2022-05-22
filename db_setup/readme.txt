Build using
docker build -t ap_project_db .

Run using
docker run -d -p 5001:1433 --name ap_db ap_project_db




you can stop using
docker stop ap_db
