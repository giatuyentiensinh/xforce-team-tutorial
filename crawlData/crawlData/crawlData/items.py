# -*- coding: utf-8 -*-

from scrapy.item import Item, Field

class Phone(Item):
	name = Field()
	price = Field()
	config = Field()
