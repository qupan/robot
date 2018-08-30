#coding=utf-8
from My_Keyword import *
import requests,json,unittest,xlrd
import ast

class Test(unittest.TestCase):

	@classmethod
	def setUpClass(self):
		self.data=read_excel('python接口.xlsx')
		#print(self.data)
		self.session = requests.session()

	#@unittest.skip('已完成')
	def test_001(self):
		'''001'''
		params =convert_dict(self.data[2][9])
		resp = self.session.get(self.data[2][5],params=params)
		assert_equal(self,resp.status_code,self.data[2][10],resp.json()['data']['resultList'][0],self.data[2][11])

	#@unittest.skip('已完成')
	def test_002(self):
		'''002'''
		params = convert_dict(self.data[3][9])
		resp = self.session.get(self.data[3][5],params=params)
		assert_equal(self,resp.status_code,self.data[3][10],resp.json()['data']['resultList'][0],self.data[3][11])

	#@unittest.skip('已完成')
	def test_003(self):
		'''003'''
		data = convert_dict(self.data[4][9])
		headers=convert_dict(self.data[4][7])
		resp = self.session.post(self.data[4][5],data=data,headers=headers,verify=False)
		assert_equal(self, resp.status_code, self.data[4][10], resp.json()['data'][0], self.data[4][11])

	#@unittest.skip('已完成')
	def test_004(self):
		'''004'''
		params=convert_dict(self.data[5][9])
		resp=self.session.get(self.data[5][5],params=params)
		assert_equal(self, resp.status_code, self.data[5][10], resp.json()['data'][0], self.data[5][11])

	#@unittest.skip('已完成')
	def test_005(self):
		'''005'''
		params=convert_dict(self.data[6][9])
		resp=self.session.get(self.data[6][5],params=params)
		assert_equal(self, resp.status_code, self.data[6][10], resp.json()['data'][0], self.data[6][11])

	#@unittest.skip('已完成')
	def test_006(self):
		'''006'''
		headers = convert_dict(self.data[7][7])
		headers = convert_dict(self.data[7][7])
		data = convert_dict(self.data[7][9])
		resp=self.session.post(self.data[7][5],data=data,headers=headers)
		assert_equal(self, resp.status_code, self.data[7][10], resp.json()['data'][0], self.data[7][11])

	#@unittest.skip('已完成')
	def test_007(self):
		'''007'''
		#headers = ast.literal_eval(self.data[8][7])
		headers = convert_dict(self.data[8][7])
		data = convert_dict(self.data[8][9])
		auth=("WST_USER","88075998")
		resp=self.session.request('post',self.data[8][5],data=data,headers=headers,auth=auth)
		assert_equal(self, resp.status_code, self.data[8][10], resp.json()['data']['resultList'][0], self.data[8][11])
		print(resp.json()['data']['resultList'][0])

	#@unittest.skip('已完成')
	def test_008(self):
		'''008'''
		headers = convert_dict(self.data[9][7])
		data = convert_dict(self.data[9][9])
		resp=self.session.post(self.data[9][5],data=data,headers=headers)
		assert_equal(self, resp.status_code, self.data[9][10], resp.json()['data']['resultList'][0], self.data[9][11])

	@classmethod
	def tearDownClass(self):
		self.session.close()

if __name__=="__main__":
	unittest.main()
