from flask import Flask
from marshmallow import Schema, fields, pre_load, validate
from flask_marshmallow import Marshmallow
from flask_sqlalchemy import SQLAlchemy


ma = Marshmallow()
db = SQLAlchemy()


class User(db.Model):
    def __init__(self,firstname,lastname,email,password,username):
        self.firstname=firstname
        self.lastname=lastname
        self.email=email
        self.password=password
        self.username=username

    __tablename__ = 'users'

    id=db.Column(db.Integer(),primary_key=True,unique=True)
    # api_key=db.Column(db.String(),primary_key=True,unique=True)
    username=db.Column(db.String(),unique=True)
    firstname=db.Column(db.String())
    lastname=db.Column(db.String())
    password=db.Column(db.String())
    email=db.Column(db.String())


    def __repr__(self):
        return '<id {}>'.format(self.id)

    def serialize(self):
        return{
            'id':self.id,
            'username':self.username,
            'firstname':self.firstname,
            'lastname':self.lastname,
            'password':self.password,
            'email':self.email,
           
            
              }
    
    def get(self):
        return {"message": "Hello, World!"}