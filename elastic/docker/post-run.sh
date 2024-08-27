#copy ssl folder from remote server to local
scp -r ds-fci-lab-elasticsearch:/opt/elk/ssl .

#parse ssl files (.crt and keys) in local and it sub dir to folder ssl-base64(create fodler if not exists)
mkdir -p ssl-base64
for file in $(find ssl -type f -name "*.crt" -o -name "*.key"); do
    base64 -i $file -o ssl-base64/$(basename $file).base64
done