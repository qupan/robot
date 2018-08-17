#coding=utf-8
import time,datetime

#离职时间是礼拜4，不超过30天,并且输出都为礼拜4

def date1():

	d1=datetime.datetime.now()
	d2=d1.weekday()
	if d2==0:
		d3=d1+datetime.timedelta(days=3)
		return d3.strftime('%Y-%m-%d')
	elif d2==1:
		d3=d1+datetime.timedelta(days=2)
		return d3.strftime('%Y-%m-%d')
	elif d2==2:
		d3=d1+datetime.timedelta(days=1)
		return d3.strftime('%Y-%m-%d')
	elif d2==3:
		d3=d1+datetime.timedelta(days=7)
		return d3.strftime('%Y-%m-%d')
	elif d2==4:
		d3=d1+datetime.timedelta(days=6)
		return d3.strftime('%Y-%m-%d')
	elif d2==5:
		d3=d1+datetime.timedelta(days=5)
		return d3.strftime('%Y-%m-%d')
	elif d2==6:
		d3=d1+datetime.timedelta(days=4)
		return d3.strftime('%Y-%m-%d')
	else:
		print ('error')

x=date1()
print (x)
