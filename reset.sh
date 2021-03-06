echo "Resetting / Initializing Appium"
echo "Clearing dev version of WD"
rm -rf node_modules/wd
echo "Installing WD and new NPM modules"
npm install .
echo "Updating/initializing submodules"
git submodule update --init
echo "Building instruments-without-delay"
pushd submodules/instruments-without-delay
./build.sh
popd
echo "Building Android bootstrap"
grunt configAndroidBootstrap
grunt buildAndroidBootstrap
if [ ! -d "./sample-code/apps/UICatalog" ]; then
    echo "Downloading UICatalog app"
    grunt downloadApp
fi
echo "Rebuilding test apps"
grunt buildApp:TestApp
grunt buildApp:UICatalog
grunt buildApp:WebViewApp
grunt configAndroidApp:ApiDemos
grunt buildAndroidApp:ApiDemos
echo "Cleaning temp files"
rm -rf /tmp/instruments_sock
rm -rf *.trace
