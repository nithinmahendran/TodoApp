from flask.signals import request_started
from flask_restful import Resource 
from models import db, User
from flask import request

class Register(Resource):
    def get(self):
        users=User.query.all()
        user_list=[]
        for i in range(0,len(users)):
            user_list.append(users[i].serialize())

        return {"status":str(user_list)},200

    def post(self):
        json_data = request.get_json(force=True)
        if not json_data:
               return {'message': 'No input data provided'}, 400
       
        user = User.query.filter_by(username=json_data['username']).first()
        if user:
            return {'message': 'User with same username already exists'}, 400
        user = User.query.filter_by(email=json_data['email']).first()
        if user:
            return {'message': 'User with same Email already exists'}, 400
        #username, email,password
        #check if username exists
        # check if the email exists
        # create a user
        # create an apikey
        user = User(
            firstname=json_data['firstname'],
            lastname=json_data['lastname'],
            email=json_data['email'],
            password=json_data['password'],
            username=json_data['username']

            )
        db.session.add(user)
        db.session.commit()

        result = User.serialize(user)

        return { "status": 'success', 'data': result }, 201
        
        # return {"message":"Posting {}".format(username)}

     
