package com.shpr.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.shpr.dao.UserDao;
import com.shpr.pojo.Feedback;
import com.shpr.pojo.Log;
import com.shpr.pojo.User;
import com.shpr.pojo.onecategory;
import com.shpr.pojo.towcategory;
import com.shpr.service.UserService;

@Service
public class UserServiceImpl implements UserService {

	@Resource 
	private UserDao userDao;
	
	@Override
	public User selecetUserByIdLogin(String user_name, String user_pwd) {
		return userDao.selecetUserByIdLogin(user_name,user_pwd);
	}

	@Override
	public List<User> getUserList() {
		return userDao.getUserList();
	}

	@Override
	public int deleteUserInfo(User user) {
		
		return userDao.deleteUserInfo(user);
	}

	@Override
	public int stopUser(User user) {
		
		return userDao.stopUser(user);
	}

	@Override
	public int starUser(User user) {
		
		return userDao.starUser(user);
	}

	@Override
	public int updateUserInfo(User user) {
		
		return userDao.updateUserInfo(user);
	}

	@Override
	public void saveLogInformation(Log logs) {
		userDao.saveLogInformation(logs);
		
	}

	@Override
	public int saveUserInfo(User user) {
		
		return userDao.saveUserInfo(user);
	}

	@Override
	public int selectUserExist(String user_name) {
		
		return userDao.selectUserExist(user_name);
	}

	@Override
	public User selectUserById(int id) {
		
		return userDao.selectUserById(id);
	}

	@Override
	public List<Log> getLogList() {
		
		return userDao.getLogList();
	}

	@Override
	public void deleteLogs(int[] ids) {
		userDao.deleteLogs(ids);
		
	}

	@Override
	public int selectUserExist1(String teach_name) {
		
		return userDao.selectUserExist1(teach_name);
	}

	@Override
	public int saveUserPass(User user) {
		
		return userDao.updateUserPwd(user);
	}
    
	//·´À¡±í
	@Override
	public int saveUserFeedback(Feedback feed) {
		
		return userDao.saveUserFeedback(feed);
	}

	@Override
	public List<User> getinformation() {
		return userDao.getinformation();
	}

	@Override
	public List<onecategory> getonecategoryList() {
		
		return userDao.getonecategoryList();
	}

	@Override
	public int saveonecateInfo(onecategory onecate) {
		
		return userDao.saveonecateInfo(onecate);
	}

	@Override
	public int updateonecateInfo(onecategory onecate) {
		
		return userDao.updateonecateInfo(onecate);
	}

	@Override
	public int deleteOnecate(onecategory onecate) {
		
		return userDao.deleteOnecate(onecate);
	}

	@Override
	public List<towcategory> gettowcategoryList() {
		
		return userDao.gettowcategoryList();
	}

	@Override
	public int savetowcateInfo(towcategory towcate) {
		
		return userDao.savetowcateInfo(towcate);
	}

	@Override
	public int updateTowcateInfo(towcategory towcate) {
		
		return userDao.updateTowcateInfo(towcate);
	}

	@Override
	public int deleteTowcate(towcategory towcate) {
		
		return userDao.deleteTowcate(towcate);
	}

	@Override
	public List<Feedback> getUserfeedList() {
		
		return userDao.getUserfeedList();
	}


	


}
