from uuid import uuid4
from flask import Blueprint, jsonify, request


vote = Blueprint("vote", __name__)


def create_vote():
    pass