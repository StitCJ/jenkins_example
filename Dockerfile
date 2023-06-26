FROM python:3.8.10-slim
COPY . .
CMD [ "python", "sum.py" ]
