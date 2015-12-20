# [Scrapy](http://doc.scrapy.org/en/0.20/index.html)

Su dung scrapy de crawl du lieu tu website
language: Python

## [Setup](http://doc.scrapy.org/en/0.20/intro/install.html)

### Yeu cau can co

* Python 2.7 (Rieng ubuntu default da co nen ko can phai cai)
* [LXML](http://lxml.de/)
* [OpenSSL](https://pypi.python.org/pypi/pyOpenSSL) (Ubuntu default exist)
* [PIP](http://www.pip-installer.org/en/latest/installing.html) or [easy_install](http://pypi.python.org/pypi/setuptools)

### Cai dat (trong tut nay dung PIP)

```shell
pip install Scrapy
```

## [Huong dan su dung](http://doc.scrapy.org/en/0.20/intro/tutorial.html)

### Tao project

```shell
# ten project: phone
scrapy startproject phone
```
![Image demo](/images/scrapy struct.png)

### Code

* File `items.py` la file se chua cau truc cua du lieu sau khi crawler ve

```python
# -*- coding: utf-8 -*-
from scrapy.item import Item, Field

class Phone(Item):
	name = Field()
	price = Field()
	img = Field()
```

* Tao file `phone.py` trong thuc muc `phone/spiders`

```python
# -*- coding: utf8 -*-

# import 2 goi thu vien cua Scrapy
from scrapy.spiders import Spider
from scrapy.selector import Selector
# import bean vua tao
from phone.items import Phone

class PhoneSpider(Spider):
	# ten start cua project
	name = "phone"
	# ten mien cua website muon crawler
	allowed_domains = ["www.trananh.vn"]
	# link trang web chua thong tin muon crawl du lieu
	start_urls = [
		"http://www.trananh.vn/dien-thoai/dien-thoai-di-dong-cid338"
	]

	# ham xy ly trong qua trinh crawler du lieu
	def parse(self, response):
		# gan bien sel la Selector cua trang web
		sel = Selector(response)
		# Thu hep vung crawler bang cach khoanh vung xpath muon crawl
		# O day ta se crawl nhung the div co id chua string "ctl00_ContentPlaceHolder1_col_right" va trong the con 
		# cua div co the ul co class chua string "pb_content clearfix"
		sites = sel.xpath('//div[contains(@id, "ctl00_ContentPlaceHolder1_col_right")]/ul[contains(@class, "pb_content clearfix")]')

		items = []
		# Chay vong lap de boc tach data trong bien sites
		for site in sites:
			# tao doi tuong item = Phone() (Phone la bean da tao trong file items.py)
			item = Phone()
			# name la bien mang thong tin ten san pham
			# du lieu cua name duoc nam trong the <li> -> <ul> -> <li class="pu_name"> -> <h4> -> <a>
			name = site.xpath('li/ul/li[contains(@class, "pb_name")]/h4/a/text()').extract()
			# vi link 'http://www.trananh.vn/dien-thoai/dien-thoai-di-dong-cid338' co ten bi cat thanh 2 phan nen co dk nay
			if len(name) > 0 :
				item['name'] = name
			else :
				item['name'] = site.xpath('li/ul/li[contains(@class, "pb_name")]/a/text()').extract()
			# bien price la du lieu trong the <li> -> <ul> -> <li class="pb_detail"> -> <ul> -> <li> -> <span> -> <a>
			item['price'] = site.xpath('li/ul/li[contains(@class, "pb_detail")]/ul/li/span/a/text()').extract()
			# bien img la du lieu co trong thuoc tinh "src" <li> -> <ul> -> <li class="pb_img_cate"> -> <a> -> <img src="...">
			item['img'] = site.xpath('li/ul/li[contains(@class, "pb_img_cate")]/a/img/@src').extract()
			# qua cac vong lap bien items se duoc add them cac phan tu item da duoc boc tach
			items.append(item)
		# ket qua duoc tra ra gia tri items
		return items
```

### Run

```shell
# output ra file items.json
scrapy crawl phone -o items.json -t json
```

# Auth: Tuyen-ng