#!/bin/bash

### tested on Ubuntu 22.04

# remove the original dummy url
shadowsocksr-cli --remove-url https://tyrantlucifer.com/ssr/ssr.txt

# put your ssr subscription url here!
MY_URL=""
shadowsocksr-cli --add-url $MY_URL
shadowsocksr-cli --update
shadowsocksr-cli --list

# on ubuntu, there are two problems:
# 1. the libsodium conflicts with the libcrypto, and we have to remove it;
# 2. the liblibcrypto.a should be linked. see https://github.com/TyrantLucifer/ssr-command-client/issues/52
sudo apt remove libsodium-dev
sudo ln -s /usr/lib/x86_64-linux-gnu/libcrypto.a /usr/lib/liblibcrypto.a

# select your node here!
MY_NODE=20
# test speed and test link.
shadowsocksr-cli --test-speed $MY_NODE

# start the global proxy.
# set your proxy port here!
MY_PROXY_PORT=9110
shadowsocksr-cli --start -p $MY_PROXY_PORT
export ALL_PROXY=socks5://127.0.0.1:$MY_PROXY_PORT

# test if the proxy is working. the curled location should be the proxy's location.
curl http://ip-api.com/json/\?lang\=zh-CN

# start the http proxy via the proxy above.
# set your http proxy port here!
MY_HTTP_PROXY_PORT=7890
shadowsocksr-cli -p $MY_PROXY_PORT --http-proxy start --http-proxy-port $MY_HTTP_PROXY_PORT

# setup the https/http proxy.
# note that the UPPER_LETTER and lower_letter should both be set!
unset ALL_PROXY
export HTTPS_PROXY=http://127.0.0.1:$MY_HTTP_PROXY_PORT
export HTTP_PROXY=http://127.0.0.1:$MY_HTTP_PROXY_PORT
export https_proxy=http://127.0.0.1:$MY_HTTP_PROXY_PORT
export http_proxy=http://127.0.0.1:$MY_HTTP_PROXY_PORT
