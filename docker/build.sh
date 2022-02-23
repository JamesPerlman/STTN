cp ../environment.yml .
docker build -t sttn -f Dockerfile .
rm environment.yml
