if [ -z $CURRENT ]; then
	CURRENT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
fi
docker build -t $REPO_PREFIX/wordpress:$REPO_TAG $CURRENT
