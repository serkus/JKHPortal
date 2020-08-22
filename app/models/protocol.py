from app import db
from datetime import datetime


class Protocol(db.Model):
    __tablename__ = 'protocols'
    id = db.Column(db.Integer, primary_key=True)
    uniq_prot_id = db.Column(db.String, unique=True)
    num_prot = db.Column(db.Integer)
    articles = db.relationship('Articles', lazy='dynamic')
    create_at = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    vote_date_start = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)
    vote_date_end = db.Column(db.DateTime, nullable=False, default=datetime.utcnow)


class Articles(db.Model):
    __tablename__ = 'articles'
    id = db.Column(db.Integer, primary_key=True)
    protocol_id = db.Column(db.Integer, db.ForeignKey('protocols.id'), nullable=False)
    title = db.Column(db.String, unique=True)
    suggestion_text = db.Column(db.String, unique=True)
    listeners = db.relationship('User', lazy='dynamic')
    users = db.relationship('User', lazy='dynamic')
    vote_yes_count = db.Column(db.Integer)
    vote_no_count = db.Column(db.Integer)
    vote_no_one_count = db.Column(db.Integer)
