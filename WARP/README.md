سلام

اینجا نحوه ی فعال سازی و تنظیم WARP رو قراره برای پنل مرزبان توضیح بدم.

پیشنهاد میشه از نسخه Fully Single Port استفاده کنید.

اول از همه نسخه پیشنهادی زیر رو برای WARP نصب کنید:


```
wget -N https://raw.githubusercontent.com/fscarmen/warp/main/warp-go.sh && bash warp-go.sh [option] [lisence]
```

گزینه ۱ زبان انگلیسی رو بزنید.
گزینه ۷ رو انتخاب کنید:



![WARP1](https://user-images.githubusercontent.com/124933548/229276332-770bcf29-dee7-4ab2-9425-5c6c4ed8a7c2.jpeg)



در مرحله ی بعد گزینه ۳ یعنی free account رو انتخاب کنید.
خب نصب وارپ تموم شد و یه سری گزینه هم برای تنظیمات بعدی به شما میده که باهاشون کاری نداریم.
```bash
 Run again with warp-go [option] [lisence], such as
 warp-go h (help)
 warp-go o (temporary warp-go switch)
 warp-go u (uninstall WARP web interface and warp-go)
 warp-go v (sync script to latest version)
 warp-go i (replace IP with Netflix support)
 warp-go 4/6 ( WARP IPv4/IPv6 single-stack)
 warp-go d (WARP dual-stack)
 warp-go n (WARP IPv4 non-global)
 warp-go g (WARP global/non-global switching)
 warp-go e (output wireguard and sing-box configuration file)
 warp-go a (Change to Free, WARP+ or Teams account) 
```
الان با دستور ip addr | grep WARP اینترفیس WARP رو چک کنید که اوکی باشه:
<p align="center">
<img width="749" alt="WARP2" src="https://user-images.githubusercontent.com/124933548/229276677-4021a4c6-47cb-4bd7-93c3-2663ac841711.png">
</p>

حالا باید default gateway سیستم رو چک کنید.

دستور echo $(curl -s ifconfig.me) رو بزنید اگر آیپی سرور رو برگردوند یعنی اوکی هست. (آیپی کلادفلر رو نمیخوایم)

در غیر این صورت دستور netplan apply رو بزنید. مجددا دستور بالا رو اجرا کنید و آیپی رو چک کنید.

بریم تنظیمات xray core رو انجام بدیم.
```
nano xray_config.json
```
در قسمت outbands کد زیر را وارد کنید:
```
        {
            "tag":"WARP",
            "protocol":"wireguard",
            "settings":{
                "secretKey":"cKE7LmCF61IhqqABGhvJ44jWXp8fKymcMAEVAzbDF2k=",
                "address":[
                    "172.16.0.2/32",
                    "fd01:5ca1:ab1e:823e:e094:eb1c:ff87:1fab/128"
                ],
                "peers":[
                    {
                        "publicKey":"bmXOC+F1FxEMF9dyiK2H5/1SUtzH0JuVo51h2wPfgyo=",
                        "endpoint":"engage.cloudflareclient.com:2408"
                    }
                ]
            }
        }
```
<p align="center">
<img width="595" alt="outbands" class="center" src="https://user-images.githubusercontent.com/124933548/229277954-17cfa0e8-6997-4510-9ab3-1f77f23b8185.png">
 </p>



در قسمت routing کد زیر وارد شود:
```
            {
                "type": "field",
                "outboundTag": "blackhole",
                "domain": [
                "geosite:category-ads-all",
                "geosite:category-ads",
                "geosite:google-ads"
                ]
            },
            {
                "type":"field",
                "outboundTag":"WARP",
                "domain": [
                    "domain:openai.com",
                    "domain:ai.com",
                    "regexp:.*\\.ir$",
                    "geosite:category-ir",
                    "geosite:google",
                    "spotify.com"
                ]
            }
```
<p align="center">
<img width="383" alt="routings" src="https://user-images.githubusercontent.com/124933548/229277940-3612aa59-b17e-4c5c-9e6c-dc84560e44fe.png">
</p>

کدهای بالا تبلیغات رو بلاک می کنه. اسپاتیفای، سایت های ایرانی، ChatGPT و اسپاتیفای رو از طریق WARP انتقال میده.


***نکته ی دیگه:‌***
در صورتی که در روش بالا بعد از مدتی دیدید مقدار رم افزایش پیدا کرده و صفحات به کندی باز میشن بهتره از روش ساکس پروکسی استفاده کنید. برای این کار کد زیر رو بزنید:


```
warp
```

حالا گزینه ی ۱۳ رو انتخاب کنید:


> Install wireproxy. Wireguard client that exposes itself as a socks5 proxy or tunnels


پورت پیش فرض رو تغییر ندید.
در قسمت outbands کد بالا که گذاشتم رو پاک کنید و کد زیر رو قرار بدید:

```
       {
                "tag": "WARP",
                "protocol": "socks",
                "settings": {
                "servers": [{
                "address": "127.0.0.1",
                "port": 40000
        }]
        }
        },
```

حالا با داکر مرزبان رو ریستارت کنید تا تغییرات اعمال بشه

موفق باشید.
