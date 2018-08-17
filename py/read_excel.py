#coding=utf-8
import xlrd

def read_excel(addr):
	a=xlrd.open_workbook(addr)
	b=a.sheets()[0]
	c=b.nrows
	d=[]
	for i in range(0,c):
		d.append(b.row_values(i))
	return d

if __name__ == '__main__':
	y=read('d:/robot/data','user')
	print(y[0])
	print(y[1])
