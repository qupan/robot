#-*- coding:utf-8 -*-
import xlrd,time,datetime,json

def read_excel(addr):
	'''
	使用xlrd模块，读取excel文件，参数addr为excel存放的绝对路径
	例如：D:/robot/data/demo.xlsx
	'''
	a=xlrd.open_workbook(addr)
	b=a.sheets()[0]
	c=b.nrows
	d=[]
	for i in range(0,c):
		d.append(b.row_values(i))
	return d

def date_weekend(x,y,z):
	'''
	判断是否是周末，+还是-，加减多少天
	参数x：【yes或no】，
	参数y：【+或-】，
	参数z：【加减的天数，输入数值】
	'''
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

def date_thursdy():
	'''
	离职时间是礼拜4，不超过30天,
	并且输出都为礼拜4
	'''
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

def convert_dict(message):
	'''
	输入入参数据，将数据装换成字典
	输入格式为：page=1,Size=4
	'''
	list_message=[]
	x=message.split(',')
	for i in range(len(x)):
		y=x[i].split('=')
		z=tuple(y)
		list_message.append(z)
	dict_message=dict(list_message)
	json_dict_message=json.dumps(dict_message,encoding="UTF-8",ensure_ascii=False)
	return json_dict_message

if __name__ == '__main__':
	x=convert_dict('page=看见看见,Size=4')
	print(x)
