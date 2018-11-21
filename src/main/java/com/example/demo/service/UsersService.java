package com.example.demo.service;

import com.example.demo.po.Users;
public interface UsersService {
    public Users findUserById(int id) throws Exception;
    public Users findUser(Users user) throws Exception;
    public String findMapByUserid() throws Exception;
}
