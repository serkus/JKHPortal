
from flask import Blueprint, jsonify, request

auth = Blueprint("auth", __name__)

@auth.route("/")
def login():
    pass