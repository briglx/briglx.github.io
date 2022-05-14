---
title: "Extract Terms from Text"
date: "2014-01-10"
tags: 
  - "nlp"
  - "python"
---

I've been playing around with NLP. I wanted to see if I could extract terms from text. With the help of the internet, I found [some answers](http://stackoverflow.com/questions/1575246/how-do-i-extract-keywords-used-in-text/1575345#1575345). It boils down to:

- [python topia library](https://pypi.python.org/pypi/topia.termextract/)
- [Yahoo keyword extraction service](http://developer.yahoo.com/search/content/V1/termExtraction.html) 

### Python

The python example looks like this

`from topia.termextract import extract

extractor = extract.TermExtractor()

text ="One company that successfully leverages a generic strategy is Costco Wholesale and that generic strategy is low-cost leadership. The company's mission is to provide popular products to customers at the lowest prices the market can offer. One way that Costco has been successful at this is by cutting expenses. Actual Costco stores are literally warehouses full of products. The company saves on many of the cosmetic aspects of typical retail stores. Additionally, most Costco stores are open 10 am to 8:30 pm during the week and closing earlier on the weekends. Less operating time saves money. Additionally, Costco operates on a membership program. This means that someone must be a member to enter the store and purchase the merchandise. One staff member stands at the entrance checking membership cards as members enter and other staff members stand at the exit matching receipts with purchases. This design allows the company to cut down on staffing costs by not needing as many employees wandering the large warehouses."

\# Show terms from text taggedTerms = sorted(extractor(text))`

The results from python are:

- ('8:30 pm', 1, 2),
- ('Actual Costco stores', 1, 3),
- ('Costco', 5, 1),
- ('Costco stores', 1, 2),
- ('company', 4, 1),
- ('member', 4, 1),
- ('membership cards', 1, 2),
- ('membership program', 1, 2),
- ('staff member', 1, 2),
- ('staff members', 1, 2),
- ('store', 4, 1)

### Yahoo Example

Calling Yahoo with the same text We get

- costco stores
- costco wholesale
- generic strategy
- cost leadership
- cosmetic aspects
- membership cards
- costco
- membership program
- warehouses
- popular products
- staff member
- retail stores
- staff members
- receipts
- lowest prices
- wholesale
- money

### Wordpress

When I posted this post, Wordpressed suggested I should tag this post with the following. So there must be a plugin somewhere, could be topia.

- Costco Wholesale
- Costco
- Costco stores
- generic strategy
- Actual Costco stores
