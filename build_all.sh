

copy_dist() {
    # Copy all files from $1/dist to ./dist/$1
    mkdir -p dist/$1
    cp -r $1/dist/* dist/$1

    # Trim "/" from the end of $1
    if [ "${1: -1}" = "/" ]; then
        echo "[INFO] Trimming '/' from end of $1"
        dir=${1::-1}
    else
        dir=$1
    fi
    edit_html ./dist/$dir/index.html
    make_rewrite $dir
}

edit_html() {
    # Edit replace icon to "favicon.ico"
    echo "[INFO] Editing $1"
    # Original icon is "https://cdn.jsdelivr.net/gh/slidevjs/slidev/assets/favicon.png"
    # New icon is "favicon.ico"
    sed -i 's/https:\/\/cdn.jsdelivr.net\/gh\/slidevjs\/slidev\/assets\/favicon.png/favicon.ico/g' $1
    # Replace fonts.googleapis.com with google-fonts.mirrors.sjtug.sjtu.edu.cn
    sed -i 's/fonts.googleapis.com/google-fonts.mirrors.sjtug.sjtu.edu.cn/g' $1
}

make_rewrite() {
    # append { "source": "/$1/(.*)", "destination": "/$1.html" } to ./dist/vercel.json
    echo "      {" >> ./dist/vercel.json
    echo "        \"source\": \"/$1/(.*)\"," >> ./dist/vercel.json
    echo "        \"destination\": \"/$1/index.html\"" >> ./dist/vercel.json
    echo "      }," >> ./dist/vercel.json
}

rm -rf ./dist

slides_list=`ls -d */`

mkdir -p dist

# Copy favicon.ico to dist
cp favicon.ico ./dist/favicon.ico

# Write ./dist/vercel.json
echo "[INFO] Writing ./dist/vercel.json"
echo '{
    "rewrites": [' > ./dist/vercel.json

for slides in $slides_list; do

    echo "[INFO] Building $slides"
    cd $slides
    npm install
    slidev build --base /$slides
    cd ..
    copy_dist $slides
done

# Delete last comma from ./dist/vercel.json
echo "[INFO] Deleting last comma from ./dist/vercel.json"
sed -i '$ d' ./dist/vercel.json
# Append closing brace to ./dist/vercel.json
echo "[INFO] Appending closing brace to ./dist/vercel.json"
echo '      }
    ]
}' >> ./dist/vercel.json