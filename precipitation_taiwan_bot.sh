#!/bin/bash

photo1_url="https://www.cwb.gov.tw/Data/fcst_img/QPF_ChFcstPrecip_6_06.png"
photo1_caption="08:00~14:00
"`date "+%Y-%m-%d"`
photo2_url="https://www.cwb.gov.tw/Data/fcst_img/QPF_ChFcstPrecip_6_12.png"
photo2_caption="14:00~22:00
"`date "+%Y-%m-%d"`

if ! [[ -f config ]]
then
	echo "please add config"
	exit 1
fi

source ./config

if ! [[ -n $token ]] || ! [[ -n $chat_id ]]
then
	echo "config error"
	exit 2
fi

request_url="https://api.telegram.org/bot"$token"/sendPhoto"

photo1_url=$photo1_url"?time="`date +%s`	# so that Telegram won't use a cached version
photo2_url=$photo2_url"?time="`date +%s`

curl --url $request_url --data-urlencode "chat_id=$chat_id" --data-urlencode "photo=$photo1_url" --data-urlencode "caption=$photo1_caption"

curl --url $request_url --data-urlencode "chat_id=$chat_id" --data-urlencode "photo=$photo2_url" --data-urlencode "caption=$photo2_caption"

printf "\nDone\n"
