import os
from config import Config
from flask_script import Manager
from redis import Redis
# from rq import Connection, Queue, Worker

from app import create_app
# from app.models import Role, User

app = create_app(os.getenv('FLASK_CONFIG') or 'default')
manager = Manager(app)


@manager.command
def test():
    """Run the unit tests."""
    import unittest
    tests = unittest.TestLoader().discover('tests')
    unittest.TextTestRunner(verbosity=2).run(tests)


# @manager.command
# def setup_dev():
#     """Runs the set-up needed for local development."""
#     setup_general()
#
#
# @manager.command
# def setup_prod():
#     """Runs the set-up needed for production."""
#     setup_general()


# def setup_general():
#     """Runs the set-up needed for both local development and production.
#        Also sets up first admin user."""
#     Role.insert_roles()
#     admin_query = Role.objects(name='Administrator').first()
#     if admin_query is not None:
#         if User.objects(email=Config.ADMIN_EMAIL).first() is None:
#             user = User(
#                 name=Config.ADMIN_NAME,
#                 role_in_band='admin',
#
#                 confirmed=True,
#                 email=Config.ADMIN_EMAIL)
#             user.password = Config.ADMIN_PASSWORD
#             user.save()
#             print('Added administrator {}'.format(user.name))
#

# @manager.command
# def run_worker():
#     """Initializes a slim rq task queue."""
#     listen = ['default']
#     conn = Redis(
#         host=app.config['RQ_DEFAULT_HOST'],
#         port=app.config['RQ_DEFAULT_PORT'],
#         db=0,
#         password=app.config['RQ_DEFAULT_PASSWORD'])
#
#     with Connection(conn):
#         worker = Worker(map(Queue, listen))
#         worker.work()


if __name__ == '__main__':
    manager.run()