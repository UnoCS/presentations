

copy_dist() {
    # Copy all files from $1/dist to ./dist/$1
    mkdir -p dist/$1
    cp -r $1/dist/* dist/$1

    # Trim "/" from the end of $1
    if [ "${1: -1}" = "/" ]; then
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
    # Replace https://fonts.googleapis.com/css2?family=Helvetica+Neue:wght@200;400;600&display=swap to /fonts.css
    sed -i 's/https:\/\/fonts.googleapis.com\/css2?family=Helvetica+Neue:wght@200;400;600&display=swap/\/fonts.css/g' $1
}

make_rewrite() {
    # append { "source": "/$1/(.*)", "destination": "/$1.html" } to ./dist/vercel.json
    echo "      {" >> ./dist/vercel.json
    echo "        \"source\": \"/$1/(.*)\"," >> ./dist/vercel.json
    echo "        \"destination\": \"/$1/index.html\"" >> ./dist/vercel.json
    echo "      }," >> ./dist/vercel.json
}

edit_package() {
    # Edit ./package.json, replace "slidev build" with "slidev build --base /$1"
    # Trim "/" from the end of $1
    if [ "${1: -1}" = "/" ]; then
        dir=${1::-1}
    else
        dir=$1
    fi
    echo "[INFO] Editing $dir/package.json"
    sed -i 's/"slidev build"/"slidev build --base \/'$dir'\/"/g' ./package.json
}

recover_package() {
    # Edit ./package.json, replace "slidev build --base /$1" with "slidev build"
    # Trim "/" from the end of $1
    if [ "${1: -1}" = "/" ]; then
        dir=${1::-1}
    else
        dir=$1
    fi
    echo "[INFO] Recovering $dir/package.json"
    sed -i 's/"slidev build --base \/'$dir'\/"/"slidev build"/g' ./package.json
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

# Write ./fonts.css
echo "[INFO] Writing ./dist/fonts.css"
echo "/* cyrillic */
@font-face {
  font-family: 'Helvetica Neue';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url(https://fonts.gstatic.com/l/font?kit=jAnfgHBgCsv4eNLTaMECf8DQsNS_exA&skey=4ad46dd97873f7d7&v=v16) format('woff2');
  unicode-range: U+0301, U+0400-045F, U+0490-0491, U+04B0-04B1, U+2116;
}
/* greek */
@font-face {
  font-family: 'Helvetica Neue';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url(https://fonts.gstatic.com/l/font?kit=jAnfgHBgCsv4eNLTaMECf8DQsNS4exA&skey=4ad46dd97873f7d7&v=v16) format('woff2');
  unicode-range: U+0370-03FF;
}
/* latin-ext */
@font-face {
  font-family: 'Helvetica Neue';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url(https://fonts.gstatic.com/l/font?kit=jAnfgHBgCsv4eNLTaMECf8DQsNS1exA&skey=4ad46dd97873f7d7&v=v16) format('woff2');
  unicode-range: U+0100-024F, U+0259, U+1E00-1EFF, U+2020, U+20A0-20AB, U+20AD-20CF, U+2113, U+2C60-2C7F, U+A720-A7FF;
}
/* latin */
@font-face {
  font-family: 'Helvetica Neue';
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url(https://fonts.gstatic.com/l/font?kit=jAnfgHBgCsv4eNLTaMECf8DQsNS7exA&skey=4ad46dd97873f7d7&v=v16) format('woff2');
  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212, U+2215, U+FEFF, U+FFFD;
}" > ./dist/fonts.css

for slides in $slides_list; do

    echo "[INFO] Building $slides"
    cd $slides
    npm install
    edit_package $slides
    npm run build
    recover_package $slides
    cd ..
    copy_dist $slides
    # If its name is "index", copy ./dist/index/index.html to ./dist/index.html
    if [ "$slides" = "index/" ]; then
        cp ./dist/index/index.html ./dist/index.html
    fi
done

# Delete last comma from ./dist/vercel.json
echo "[INFO] Deleting last comma from ./dist/vercel.json"
sed -i '$ d' ./dist/vercel.json
# Append closing brace to ./dist/vercel.json
echo "[INFO] Appending closing brace to ./dist/vercel.json"
echo '      }
    ]
}' >> ./dist/vercel.json