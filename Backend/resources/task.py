from flask.signals import request_started
from flask_restful import Resource
from models import db, User,Task
from flask import request
import random
import string


class Tasks(Resource):
    def post(self):
        header = request.headers["Authorization"]
        json_data = request.get_json(force=True)
        if not header:
            return {"Message": "No Api Key!"},400
        else:
            user = User.query.filter_by(api_key=header).first()
          
            if user:
                task =Task(
                    title=json_data['title'],
                    user_id=user.id,
                    note=json_data['note'],
                    completed=json_data['completed'],
                    repeats=json_data['repeats'],
                    deadline=json_data['deadline'],
                    reminder=json_data['reminder']

                    )
                db.session.add(task)
                db.session.commit()
                
                result=Task.serialize(task)
                return {"status": 'success', 'data': result}, 201
            else:
                return {"Message": "No user with that api Key!"},400

    def get(self):
        result = []
        #json_data = request.get_json(force=True)
        header = request.headers["Authorization"]
        if not header:
            return {"Message": "No Api Key!"},400
        else:
            user = User.query.filter_by(api_key=header).first()
            if user:
                tasks=Task.query.filter_by(user_id=user.id).all()
                for task in tasks:
                    result.append(Task.serialize(task))

        return {"status": 'success', 'data': result}, 201