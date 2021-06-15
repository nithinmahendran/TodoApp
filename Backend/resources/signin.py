from flask.signals import request_started
from flask_restful import Resource
from models import db, User
from flask import request
import random
import string


class Signin(Resource):

    def post(self):
        result = ""
        json_data = request.get_json(force=True)
        header = request.headers["Authorization"]
        if not header:
            result=self.username_and_password_signin(json_data)
        else:
            user = User.query.filter_by(api_key=header).first()
            if user:
                result = User.serialize(user)
            else:
                result=self.username_and_password_signin(json_data)

        return {"status": 'success', 'data': result}, 201

    def username_and_password_signin(self, json_data):
        if not json_data:
            return {'message': 'No input data provided'}, 400

        user = User.query.filter_by(username=json_data['username']).first()
        if not user:
            return {'message': 'User doesn\'t exists'}, 400

            
        if user.password != json_data["password"]:
            return {'message': 'Password Incorrect'}, 400
            

        return User.serialize(user)

    def generate_key(self):
        return ''.join(random.choice(string.ascii_letters + string.digits) for _ in range(50))
     
