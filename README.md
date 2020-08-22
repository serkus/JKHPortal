# JKHPortal

For start project you need to write the following command:

```
touch .env
echo SECRET_KEY=<SECRET_KEY> >> .env
echo JWT_SECRET_KEY=<JWT_SECRET_KEY> &>> .env
pipenv install -r requirements.txt
pipenv run python -m manage runserver
```