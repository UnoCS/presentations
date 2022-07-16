

copy_assets() {
    # Copy all files from $1/dist/assets to ./dist/assets
    echo "Copying assets from $1/dist/assets to ./dist/assets"
    cp -r $1/dist/assets/* ./dist/assets
}

copy_index() {
    # Copy $1/dist/index.html to ./dist/index.html
    echo "Moving index.html from $1dist/index.html to ./dist/$1.html"
    # Trim "/" from the end of $1
    if [ "${1: -1}" = "/" ]; then
        echo "Trimming '/' from end of $1"
        dir=${1::-1}
    else
        dir=$1
    fi
    cp $1dist/index.html ./dist/$dir.html
    edit_index ./dist/$dir.html
}

edit_index() {
    # Edit replace icon to "favicon.ico"
    echo "Editing $1"
    # Original icon is "https://cdn.jsdelivr.net/gh/slidevjs/slidev/assets/favicon.png"
    # New icon is "favicon.ico"
    sed -i 's/https:\/\/cdn.jsdelivr.net\/gh\/slidevjs\/slidev\/assets\/favicon.png/favicon.ico/g' $1
    # Replace fonts.googleapis.com with google-fonts.mirrors.sjtug.sjtu.edu.cn
    sed -i 's/fonts.googleapis.com/google-fonts.mirrors.sjtug.sjtu.edu.cn/g' $1
}

rm -rf ./dist

slides_list=`ls -d */`

mkdir -p dist
mkdir -p dist/assets

# Copy favicon.ico to dist
cp favicon.ico ./dist/favicon.ico

for slides in $slides_list; do

    echo "Building $slides"
    cd $slides
    npm install
    npm run build
    cd ..
    copy_assets $slides
    copy_index $slides
done
