#-*- coding:utf-8 -*-
import xlrd,time,datetime,json
from selenium import webdriver

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

def read_excel_data(addr,read_way='row'):
	'''
	使用xlrd模块，读取excel文件，参数addr为excel存放的绝对路径
	例如：D:/robot/data/demo.xlsx
	read_way读取的方法，默认是列读取，值为col时候
	'''
	if read_way=='row':
		a=xlrd.open_workbook(addr)
		number=a.sheets()
		data=[]
		for j in range(len(number)):
			b=a.sheets()[j]
			c=b.nrows
			d=[]
			for i in range(c):
				d.append(b.row_values(i))
			data.append(d)
		return data
	elif read_way=='col':
		a=xlrd.open_workbook(addr)
		number=a.sheets()
		data=[]
		for j in range(len(number)):
			b=a.sheets()[j]
			c=b.ncols
			d=[]
			for i in range(c):
				d.append(b.col_values(i))
			data.append(d)
		return data

def date_monday():
	'''
	并且输出都为礼拜1
	'''
	d1=datetime.datetime.now()
	d2=d1.weekday()
	if d2==0:
		return d2.strftime('%Y-%m-%d')
	elif d2==1:
		d3=d1-datetime.timedelta(days=1)
		return d3.strftime('%Y-%m-%d')
	elif d2==2:
		d3=d1-datetime.timedelta(days=2)
		return d3.strftime('%Y-%m-%d')
	elif d2==3:
		d3=d1-datetime.timedelta(days=3)
		return d3.strftime('%Y-%m-%d')
	elif d2==4:
		d3=d1-datetime.timedelta(days=4)
		return d3.strftime('%Y-%m-%d')
	else:
		print ('error')

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

#web模式
def create_headlesschrome_options():
	chrome_options=webdriver.ChromeOptions()
	chrome_options.add_argument('--no-sandbox')#解决DevToolsActivePort文件不存在的报错
	chrome_options.add_argument('--headless')#浏览器不提供可视化页面. linux下如果系统不支持可视化不加这条会启动失败
	chrome_options.add_argument('--disable-gpu')#谷歌文档提到需要加上这个属性来规避bug
	chrome_options.add_argument('--window-size=1920,1080')#指定浏览器分辨率
	#chrome_options.add_argument('blink-settings=imagesEnabled=false') #不加载图片, 提升速度
	chrome_options.add_argument('--hide-scrollbars') #隐藏滚动条, 应对一些特殊页面
	#chrome_options.binary_location = r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" #手动指定使用的浏览器位置
#H5模式
	return	chrome_options

def create_headlessfirefox_options():
	firefox_options=webdriver.FirefoxOptions()
	firefox_options.add_argument('--no-sandbox')#解决DevToolsActivePort文件不存在的报错
	firefox_options.add_argument('--headless')#浏览器不提供可视化页面. linux下如果系统不支持可视化不加这条会启动失败
	firefox_options.add_argument('--disable-gpu')#谷歌文档提到需要加上这个属性来规避bug
	firefox_options.add_argument('--window-size=1920,1080')#指定浏览器分辨率
	#firefox_options.add_argument('blink-settings=imagesEnabled=false') #不加载图片, 提升速度
	firefox_options.add_argument('--hide-scrollbars') #隐藏滚动条, 应对一些特殊页面
	#firefox_options.binary_location = r"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" #手动指定使用的浏览器位置
#H5模式
	return	firefox_options

def create_app_headlesschrome_options(deviceName='Mei Zu'):
	devname={'deviceName':deviceName}
	chrome_options=webdriver.ChromeOptions()
	chrome_options.add_argument('--headless')
	chrome_options.add_argument('disable-gpu')
	#chrome_options.add_argument('--deviceName=iPhone 5/SE')
	chrome_options.add_experimental_option('mobileEmulation',devname)
	# chrome_options.add_argument('--window-size=1920,1080')
	return chrome_options

def convert_json(**kargs):
	'''
	输入入参数据，将数据转换成json格式并返回
	输入格式为：number=23,false=False,true=True,none=None
	'''
	data = {}
	for i,j in kargs.items():
		if (j == "False") or (j == "false"):
			data[i] = False
		elif (j == "True") or (j == "true"):
			data[i] = True
		elif (j == "None") or (j == "null"):
			data[i] = None
		elif j.isdigit() == True:
			data[i] = int(j)
		else:
			data[i] = j
	json_data = json.dumps(data,indent=4,ensure_ascii=False)
	return json_data


if __name__=='__main__':
	# data=read_excel('C:\\Project\\000-Deomo\\data\\xml-data.xlsx')
	# print(data[0][0])
	data=convert_json(announceId="False",grade="水瓶座",code="200",cc="None",dd='dfkan')
	print(data)
