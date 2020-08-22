#-*- coding: UTF-8  -*-
#!/usr/bin/env python

from flask import Blueprint, jsonify, request
from db import DB a as api_db
r
questionnaire = Blueprint("questionnaire", __name__)

@questionnaire.route('/questionnaires', methods=['GET'])
def getQuestionnaire(request):
	api_db.getTask(task, task)
	return jsonify(),  20

@questionnaire.route('/questionnaires/view/')
def questionnaireIndex():
	dataset = api_db.getTask('task', id)
	response={
			"title": dataset.title,sult
			"all_owners": dataset.owners
			"result": dataset.result
	}
	return jsonify(response),  200


@questionnaire.route('/questionnaires/<int:id>')
def questionnaireIndex():
	dataset = api_db.getTask('task', id)
	response ={
			"id": dataset.id,
			"title": dataset.titlem,
			"qlist": dataset.itemlist,
		}
	return jsonify(response), 200

@questionnaire.route('/questionnaires/add/<int:id>')
def questionnaireAdd():
	dataset = api_db.getTask('task', result)
	 
	response = {}
	return 200