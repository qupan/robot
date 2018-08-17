#coding=utf-8
import time,datetime

#判断是否是周末，+还是-，加减多少天
def date(x,y,z):

	d1=datetime.datetime.now()
	if x=='yes':
		if y=='+':
			d2=d1+datetime.timedelta(days=z)
			d3=d2.weekday()
			if d3==5:
				d4=d2+datetime.timedelta(days=2)
				return d4.strftime('%Y-%m-%d')
			elif d3==6:
				d4=d2+datetime.timedelta(days=1)
				return d4.strftime('%Y-%m-%d')
			else:
				return d2.strftime('%Y-%m-%d')
		elif y=='-':
			d2=d1-datetime.timedelta(days=z)
			d3=d2.weekday()
			if d3==5:
				d4=d2-datetime.timedelta(days=1)
				return d4.strftime('%Y-%m-%d')
			elif d3==6:
				d4=d2-datetime.timedelta(days=2)
				return d4.strftime('%Y-%m-%d')
			else:
				return d2.strftime('%Y-%m-%d')
		else:
			print ('arguments error')
	elif x=='no':
		if y=='+':
			d2=d1+datetime.timedelta(days=z)
			return d2.strftime('%Y-%m-%d')
		elif y=='-':
			d2=d1-datetime.timedelta(days=z)
			return d2.strftime('%Y-%m-%d')
		else:
			print ('arguments error')
	else:
		print ('arguments error')

x=date('yes','-',8)
print (x)
