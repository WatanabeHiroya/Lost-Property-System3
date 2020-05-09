# coding: utf-8

User.create!(name: "管理者",
             email: "admin@email.com",
             password: "password",
             password_confirmation: "password",
             admin: true)

User.create!(name: "test",
             email: "test@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false)
             
User.create!(name: "test2",
             email: "test2@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false)