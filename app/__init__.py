import os

import wtforms_json
from flask import Flask, jsonify
from flask_assets import Environment
from flask_compress import Compress
# from flask_jwt_extended import JWTManager
# from flask_login import LoginManager
from flask_mail import Mail
# from flask_rq import RQ
# from flask_uploads import UploadSet, configure_uploads, patch_request_class
# from flask_wtf import CsrfProtect
from flask_cors import CORS
# from celery import Celery

from config import config

# from .assets import app_css, app_js, vendor_css, vendor_js

basedir = os.path.abspath(os.path.dirname(__file__))

# mail = Mail()
cors = CORS()
# db = MongoEngine()
wtforms_json.init()
# csrf = CsrfProtect()
compress = Compress()
# celery = Celery(broker='redis://localhost:6379/0')
# jwt = JWTManager()
# photos = UploadSet('photos', tuple('jpg jpe jpeg png gif svg bmp heic'.split()))
# docs = UploadSet('docs', tuple('txt pdf docx rtf'.split()))
# login_manager = LoginManager()
# login_manager.session_protection = 'strong'
# login_manager.login_view = 'admin.login'


def create_app(config_name):
    app = Flask(__name__)
    app.config.from_object(config[config_name])
    # not using sqlalchemy education system, hence disabling it
    config[config_name].init_app(app)
    # Set up extensions
    # mail.init_app(app)
    # db.init_app(app)
    # login_manager.init_app(app)
    # csrf.init_app(app)
    # jwt.init_app(app)
    compress.init_app(app)
    # RQ(app)
    cors.init_app(app, resources={r"/v1/*": {"origins": "*"}})
    # configure_uploads(app, [photos, docs])
    # patch_request_class(app, 10 * 1024 * 1024)
    # swagger.init_app(app)
    # # Register Jinja template functions
    # from .utils import register_template_utils
    # register_template_utils(app)

    # Set up asset pipeline
    assets_env = Environment(app)
    dirs = ['assets/styles', 'assets/scripts']
    for path in dirs:
        assets_env.append_path(os.path.join(basedir, path))
    assets_env.url_expire = True


    # Configure SSL if platform supports it
    if not app.debug and not app.testing and not app.config['SSL_DISABLE']:
        from flask_sslify import SSLify
        SSLify(app)

        # Create app blueprints
    from .api.blockchain import blockchain as blockchain_blueprint
    app.register_blueprint(blockchain_blueprint, url_prefix='/v1/vote')

    return app

