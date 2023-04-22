cd ~/dev/blitz/api/dev

docker rmi blitz_api
docker build -f Dockerfile.regtest -t blitz_api . 

cd -
