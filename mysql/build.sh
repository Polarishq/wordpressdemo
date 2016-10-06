if [ -z $CURRENT ]; then
	CURRENT=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
fi

docker build -t $REPO_PREFIX/mysql:$REPO_TAG $CURRENT
