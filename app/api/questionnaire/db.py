#-*- coding: Utf-8 -*- 
#1/usr/bin/env pytho3

import sqlite3
import os, sys

class DB ():
	def __init__ (self):
		self.conn = sqlite3.connection("app_db")
		self.cur = conn.cursor()
		self.templateDB=[
				{'select':"<SELECT TABLE  %s  from %s >"},
				{'create':"<CREATE TABLE IF NOT EXISTS %s >"},
				{'insert':"<INSERT INTO %s (%s) VALUES (%s)>"}]	

	def _execTamplate(self, template, tab, listdata)
		temp = template in self.templateDB
		return(temp %  %tab, %listdata)
		self.conn.commit()

	def newTask(self, tab_name, listdata):
		self.cur.execute(self._execTamplate('insert', tab_name, listdata))
		self.conn.commit()

	def getTask(self, tab_name, listdata):
		selt.cur.execute(self._execTamplate('select', tab_name, listdata)
