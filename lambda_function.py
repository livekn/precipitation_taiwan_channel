import dateutil.tz
import os
import urllib.parse
import urllib.request
from datetime import datetime

def lambda_handler(event, context):
    taipei_timezone = dateutil.tz.gettz('Asia/Taipei')

    photo1_url = "https://www.cwa.gov.tw/Data/fcst_img/QPF_ChFcstPrecip_6_06.png"
    photo1_caption = "08:00~14:00\n" + datetime.now(tz=taipei_timezone).strftime("%Y-%m-%d")
    photo2_url = "https://www.cwa.gov.tw/Data/fcst_img/QPF_ChFcstPrecip_6_12.png"
    photo2_caption = "14:00~22:00\n" + datetime.now(tz=taipei_timezone).strftime("%Y-%m-%d")

    token = os.environ.get("TOKEN")
    chat_id = os.environ.get("CHAT_ID")

    if not token or not chat_id:
        return "Missing environment variable(s)"

    request_url = f"https://api.telegram.org/bot{token}/sendPhoto"

    photo1_url = f"{photo1_url}?time={datetime.now().timestamp()}"
    photo2_url = f"{photo2_url}?time={datetime.now().timestamp()}"

    params1 = {
        "chat_id": chat_id,
        "photo": photo1_url,
        "caption": photo1_caption
    }

    params2 = {
        "chat_id": chat_id,
        "photo": photo2_url,
        "caption": photo2_caption
    }

    urllib.request.urlopen(request_url, data=urllib.parse.urlencode(params1).encode("utf-8"))
    urllib.request.urlopen(request_url, data=urllib.parse.urlencode(params2).encode("utf-8"))

    return "Done"
