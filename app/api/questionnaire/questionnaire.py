#-*- coding: UTF-8  -*-
#!/usr/bin/env python

rom flask import Blueprint, jsonify, request

from app.services.BlockChein.classes import Blockchain

questionnaire = Blueprint("questionnaire", __name__)

@questionnaire.route('/questionnaires', methods=['GET'])

def getQuestionnaire():
	pass
questionnaire.route('/questionnaires/<int:id>')
def questionnaireIndex():
	pass