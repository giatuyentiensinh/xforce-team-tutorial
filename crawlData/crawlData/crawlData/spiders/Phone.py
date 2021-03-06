# -*- coding: utf-8 -*-

# import 2 goi thu vien cua Scrapy
from scrapy.spiders import Spider
from scrapy.selector import Selector
# import bean vua tao
from crawlData.items import Phone

class PhoneSpider(Spider):
	# ten start cua project
	name = "phone"
	# ten mien cua website muon crawler
	allowed_domains = ["www.thegioididong.com"]
	# link trang web chua thong tin muon crawl du lieu
	start_urls = [
		"https://www.thegioididong.com/"
	]

	# ham xy ly trong qua trinh crawler du lieu
	def parse(self, response):
		# gan bien sel la Selector cua trang web
		sel = Selector(response)
		# Thu hep vung crawler bang cach khoanh vung xpath muon crawl
		# O day ta se crawl nhung the figure co class chua string "bginfo"
		sites = sel.xpath('//figure[contains(@class, "bginfo")]')
		items = []
		# Chay vong lap de boc tach data trong bien sites
		for site in sites:
			# tao doi tuong item = Phone() (Phone la bean da tao trong file items.py)
			item = Phone()
			# name la bien mang thong tin ten san pham
			# du lieu cua bien name nam trong the <h3>
			item['name'] = site.xpath('h3/text()').extract()
			# du lieu cua bien price nam trong the <strong>
			item['price'] = site.xpath('strong/text()').extract()
			# dieu lieu cua bien config nam trong cac the <span>
			item['config'] = site.xpath('span/text()').extract()
			items.append(item)
		print items
		return items