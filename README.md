# pharmacy-search-app-backend

薬局を検索し比較検討できるアプリです。<br>
[pharmacy-search-app-frontend](https://github.com/amegumi3/pharmacy-search-app-frontend)のバックエンド部分になります。<br>

![Read_me用_AdobeExpress](https://user-images.githubusercontent.com/102279858/222644426-2408183f-828e-413a-9892-c31f966448ed.gif)

物価高騰が続き、今まで以上に節約に意識が向くようになりました。<br>
今までは病院から一番近くの薬局に行っていましたが、お薬代が安くすむ薬局を選択することで節約になると思い作成しました。

# Feature
**1. キーワード周辺の薬局探し**<br>
キーワード付近の薬局を探すことができます。住所や薬局名から検索することも可能です。
<br>
<br>
**2. お薬代の節約ができる**<br>
詳細ページで各薬局の地方厚生局への届出情報を確認することができます。
届出の合計点数が低い薬局を選択することで、お薬代を節約することができます。（* 関連通知等により表記のものと異なる可能性があるため、厳密な比較をすることはできません。あくまで参考としての活用になります。）
<br>
<br>
**ex.**<br>
下の画像では、A薬局とB薬局で93点の差があります。
窓口での負担割合を３割とした場合、B薬局を選択することで270円ほど節約になります。
<br>
＜A薬局＞
![スクリーンショット 2023-03-01 21 15 10](https://user-images.githubusercontent.com/102279858/222136646-a5382c5c-2102-43e0-8a37-c696f55fdd58.png)
＜B薬局＞
![スクリーンショット 2023-03-01 21 26 35](https://user-images.githubusercontent.com/102279858/222139059-316c09e0-67ce-4622-893d-8dc5ae399f1d.png)
<br>
<br>
**3. 通常とは違った視点でみる薬局の特徴**
<br>
届出要件を基に独自で薬局の特徴を設定しました。地域医療に貢献している薬局など、通常とはちがった視点で薬局を選ぶことができます。
<br>
<br>

# ER
<img width="985" alt="スクリーンショット 2023-03-05 20 11 22" src="https://user-images.githubusercontent.com/102279858/222956982-afd7eee4-7f48-4291-8b5e-f44c1c1aae5f.png">

# Preparation
このアプリでは、Yahoo!ジオコーダAPIを使用します。<br>
事前に[アプリケーションIDを用意](https://e.developer.yahoo.co.jp/dashboard/)し、
取得したIDを**API_KEY**に格納してご利用ください。
```
API_KEY = "取得したアプリケーションID"
```
