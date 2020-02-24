PROJ=$1

if [ -z $PROJ ]; then
	echo 'Set proj name, no pauses in name'
	exit -1
fi

unzip springlearn.zip
mkdir $PROJ
mv springlearn/* $PROJ
rm -rf springlearn

pushd .

cd $PROJ
git init
git add -A
git commit -m "initial commit"

find . -type f -print0 | xargs -0 sed -i 's/springlearn/'$PROJ'/g'

PROJ_CLASS="${PROJ^}"
find . -type f -print0 | xargs -0 sed -i 's/Springlearn/'$PROJ_CLASS'/g'

PROJ_SRC='src/main/java/com/nidys/'
mv $PROJ_SRC'/springlearn' $PROJ_SRC'/'$PROJ
mv $PROJ_SRC'/'$PROJ'/'SpringlearnApplication.java $PROJ_SRC'/'$PROJ'/'$PROJ_CLASS'Application.java'

PROJ_TEST='src/test/java/com/nidys/'
mv $PROJ_TEST'/springlearn' $PROJ_TEST'/'$PROJ
mv $PROJ_TEST'/'$PROJ'/'SpringlearnApplicationTests.java $PROJ_TEST'/'$PROJ'/'$PROJ_CLASS'ApplicationTests.java'
echo 'Project setup in'`pwd`

popd

echo 'Project '$PROJ' created.'
