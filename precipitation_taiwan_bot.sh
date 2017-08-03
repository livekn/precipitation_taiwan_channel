#!/bin/bash

photo1_url="http://www.cwb.gov.tw/V7/forecast/fcst/Data/QPF_ChFcstPrecip_6_06.jpg"
photo1_caption="8~14"
photo2_url="http://www.cwb.gov.tw/V7/forecast/fcst/Data/QPF_ChFcstPrecip_6_12.jpg"
photo2_caption="14~20"

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

curl --url $request_url --data-urlencode 'chat_id='$chat_id --data-urlencode 'photo='$photo1_url --data-urlencode 'caption='$photo1_caption --data-urlencode 'time='`date +%s`

curl --url $request_url --header 'content-type: application/x-www-form-urlencoded' --data-urlencode 'chat_id='$chat_id --data-urlencode 'photo='$photo2_url --data-urlencode 'caption='$photo2_caption --data-urlencode 'time='`date +%s`
