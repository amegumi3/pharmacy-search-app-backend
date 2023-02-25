
PROFILE_NAME="megumi"
ACCOUNT_ID="480686852336"
aws ecr --profile $PROFILE_NAME get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com

REPOSITORY_NAME="pharmacy-search-app-backend"
docker build -t $REPOSITORY_NAME .
docker tag $REPOSITORY_NAME:latest $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/$REPOSITORY_NAME:latest
docker push $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/$REPOSITORY_NAME:latest