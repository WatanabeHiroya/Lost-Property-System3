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
             
User.create!(name: "test3",
             email: "test3@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false)
             
User.create!(name: "test4",
             email: "test4@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false)
             
User.create!(name: "test5",
             email: "test5@email.com",
             password: "password",
             password_confirmation: "password",
             admin: false)