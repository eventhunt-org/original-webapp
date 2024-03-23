FROM python:3.9.18-bullseye

WORKDIR /home/python

RUN apt update && apt install -y zlib1g-dev build-essential libjpeg-dev

ADD requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ADD . .
RUN python manage.py migrate

STOPSIGNAL SIGINT
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

